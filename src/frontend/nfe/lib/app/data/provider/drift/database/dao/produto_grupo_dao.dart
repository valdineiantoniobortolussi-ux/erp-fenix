import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'produto_grupo_dao.g.dart';

@DriftAccessor(tables: [
	ProdutoGrupos,
	ProdutoSubgrupos,
])
class ProdutoGrupoDao extends DatabaseAccessor<AppDatabase> with _$ProdutoGrupoDaoMixin {
	final AppDatabase db;

	List<ProdutoGrupo> produtoGrupoList = []; 
	List<ProdutoGrupoGrouped> produtoGrupoGroupedList = []; 

	ProdutoGrupoDao(this.db) : super(db);

	Future<List<ProdutoGrupo>> getList() async {
		produtoGrupoList = await select(produtoGrupos).get();
		return produtoGrupoList;
	}

	Future<List<ProdutoGrupo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		produtoGrupoList = await (select(produtoGrupos)..where((t) => expression)).get();
		return produtoGrupoList;	 
	}

	Future<List<ProdutoGrupoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(produtoGrupos)
			.join([]);

		if (field != null && field != '') { 
			final column = produtoGrupos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		produtoGrupoGroupedList = await query.map((row) {
			final produtoGrupo = row.readTableOrNull(produtoGrupos); 

			return ProdutoGrupoGrouped(
				produtoGrupo: produtoGrupo, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var produtoGrupoGrouped in produtoGrupoGroupedList) {
			produtoGrupoGrouped.produtoSubgrupoGroupedList = [];
			final queryProdutoSubgrupo = ' id_produto_grupo = ${produtoGrupoGrouped.produtoGrupo!.id}';
			expression = CustomExpression<bool>(queryProdutoSubgrupo);
			final produtoSubgrupoList = await (select(produtoSubgrupos)..where((t) => expression)).get();
			for (var produtoSubgrupo in produtoSubgrupoList) {
				ProdutoSubgrupoGrouped produtoSubgrupoGrouped = ProdutoSubgrupoGrouped(
					produtoSubgrupo: produtoSubgrupo,
				);
				produtoGrupoGrouped.produtoSubgrupoGroupedList!.add(produtoSubgrupoGrouped);
			}

		}		

		return produtoGrupoGroupedList;	
	}

	Future<ProdutoGrupo?> getObject(dynamic pk) async {
		return await (select(produtoGrupos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ProdutoGrupo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM produto_grupo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ProdutoGrupo;		 
	} 

	Future<ProdutoGrupoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ProdutoGrupoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.produtoGrupo = object.produtoGrupo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(produtoGrupos).insert(object.produtoGrupo!);
			object.produtoGrupo = object.produtoGrupo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ProdutoGrupoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(produtoGrupos).replace(object.produtoGrupo!);
		});	 
	} 

	Future<int> deleteObject(ProdutoGrupoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(produtoGrupos).delete(object.produtoGrupo!);
		});		
	}

	Future<void> insertChildren(ProdutoGrupoGrouped object) async {
		for (var produtoSubgrupoGrouped in object.produtoSubgrupoGroupedList!) {
			produtoSubgrupoGrouped.produtoSubgrupo = produtoSubgrupoGrouped.produtoSubgrupo?.copyWith(
				id: const Value(null),
				idProdutoGrupo: Value(object.produtoGrupo!.id),
			);
			await into(produtoSubgrupos).insert(produtoSubgrupoGrouped.produtoSubgrupo!);
		}
	}
	
	Future<void> deleteChildren(ProdutoGrupoGrouped object) async {
		await (delete(produtoSubgrupos)..where((t) => t.idProdutoGrupo.equals(object.produtoGrupo!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from produto_grupo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}