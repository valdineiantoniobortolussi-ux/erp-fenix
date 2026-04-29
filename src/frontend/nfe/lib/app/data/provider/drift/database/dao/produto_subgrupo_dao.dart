import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'produto_subgrupo_dao.g.dart';

@DriftAccessor(tables: [
	ProdutoSubgrupos,
	Produtos,
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
			.join([]);

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

			return ProdutoSubgrupoGrouped(
				produtoSubgrupo: produtoSubgrupo, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var produtoSubgrupoGrouped in produtoSubgrupoGroupedList) {
			produtoSubgrupoGrouped.produtoGroupedList = [];
			final queryProduto = ' id_produto_subgrupo = ${produtoSubgrupoGrouped.produtoSubgrupo!.id}';
			expression = CustomExpression<bool>(queryProduto);
			final produtoList = await (select(produtos)..where((t) => expression)).get();
			for (var produto in produtoList) {
				ProdutoGrouped produtoGrouped = ProdutoGrouped(
					produto: produto,
				);
				produtoSubgrupoGrouped.produtoGroupedList!.add(produtoGrouped);
			}

		}		

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
		for (var produtoGrouped in object.produtoGroupedList!) {
			produtoGrouped.produto = produtoGrouped.produto?.copyWith(
				id: const Value(null),
				idProdutoSubgrupo: Value(object.produtoSubgrupo!.id),
			);
			await into(produtos).insert(produtoGrouped.produto!);
		}
	}
	
	Future<void> deleteChildren(ProdutoSubgrupoGrouped object) async {
		await (delete(produtos)..where((t) => t.idProdutoSubgrupo.equals(object.produtoSubgrupo!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from produto_subgrupo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}