import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'produto_subgrupo_dao.g.dart';

@DriftAccessor(tables: [
	ProdutoSubgrupos,
	ProdutoGrupos,
])
class ProdutoSubgrupoDao extends DatabaseAccessor<AppDatabase> with _$ProdutoSubgrupoDaoMixin {
	final AppDatabase db;

	List<ProdutoSubgrupo> produtoSubgrupoList = []; 
	List<ProdutoSubgrupoGrouped> produtoSubgrupoGroupedList = []; 

	ProdutoSubgrupoDao(this.db) : super(db);

	Future<List<ProdutoSubgrupo>> getList() async {
		produtoSubgrupoList = await select(produtoSubgrupos).get();
		return produtoSubgrupoList;
	}

	Future<List<ProdutoSubgrupo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		produtoSubgrupoList = await (select(produtoSubgrupos)..where((t) => expression)).get();
		return produtoSubgrupoList;	 
	}

	Future<List<ProdutoSubgrupoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(produtoSubgrupos)
			.join([ 
				leftOuterJoin(produtoGrupos, produtoGrupos.id.equalsExp(produtoSubgrupos.idProdutoGrupo)), 
			]);

		if (field != null && field != '') { 
			final column = produtoSubgrupos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		produtoSubgrupoGroupedList = await query.map((row) {
			final produtoSubgrupo = row.readTableOrNull(produtoSubgrupos); 
			final produtoGrupo = row.readTableOrNull(produtoGrupos); 

			return ProdutoSubgrupoGrouped(
				produtoSubgrupo: produtoSubgrupo, 
				produtoGrupo: produtoGrupo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var produtoSubgrupoGrouped in produtoSubgrupoGroupedList) {
		//}		

		return produtoSubgrupoGroupedList;	
	}

	Future<ProdutoSubgrupo?> getObject(dynamic pk) async {
		return await (select(produtoSubgrupos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ProdutoSubgrupo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM produto_subgrupo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ProdutoSubgrupo;		 
	} 

	Future<ProdutoSubgrupoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ProdutoSubgrupoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.produtoSubgrupo = object.produtoSubgrupo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(produtoSubgrupos).insert(object.produtoSubgrupo!);
			object.produtoSubgrupo = object.produtoSubgrupo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ProdutoSubgrupoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(produtoSubgrupos).replace(object.produtoSubgrupo!);
		});	 
	} 

	Future<int> deleteObject(ProdutoSubgrupoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(produtoSubgrupos).delete(object.produtoSubgrupo!);
		});		
	}

	Future<void> insertChildren(ProdutoSubgrupoGrouped object) async {
	}
	
	Future<void> deleteChildren(ProdutoSubgrupoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from produto_subgrupo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}