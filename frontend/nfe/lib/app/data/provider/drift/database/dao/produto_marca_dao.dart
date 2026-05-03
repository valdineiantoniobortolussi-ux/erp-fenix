import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'produto_marca_dao.g.dart';

@DriftAccessor(tables: [
	ProdutoMarcas,
	Produtos,
])
class ProdutoMarcaDao extends DatabaseAccessor<AppDatabase> with _$ProdutoMarcaDaoMixin {
	final AppDatabase db;

	List<ProdutoMarca> produtoMarcaList = []; 
	List<ProdutoMarcaGrouped> produtoMarcaGroupedList = []; 

	ProdutoMarcaDao(this.db) : super(db);

	Future<List<ProdutoMarca>> getList() async {
		produtoMarcaList = await select(produtoMarcas).get();
		return produtoMarcaList;
	}

	Future<List<ProdutoMarca>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		produtoMarcaList = await (select(produtoMarcas)..where((t) => expression)).get();
		return produtoMarcaList;	 
	}

	Future<List<ProdutoMarcaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(produtoMarcas)
			.join([]);

		if (field != null && field != '') { 
			final column = produtoMarcas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		produtoMarcaGroupedList = await query.map((row) {
			final produtoMarca = row.readTableOrNull(produtoMarcas); 

			return ProdutoMarcaGrouped(
				produtoMarca: produtoMarca, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var produtoMarcaGrouped in produtoMarcaGroupedList) {
			produtoMarcaGrouped.produtoGroupedList = [];
			final queryProduto = ' id_produto_marca = ${produtoMarcaGrouped.produtoMarca!.id}';
			expression = CustomExpression<bool>(queryProduto);
			final produtoList = await (select(produtos)..where((t) => expression)).get();
			for (var produto in produtoList) {
				ProdutoGrouped produtoGrouped = ProdutoGrouped(
					produto: produto,
				);
				produtoMarcaGrouped.produtoGroupedList!.add(produtoGrouped);
			}

		}		

		return produtoMarcaGroupedList;	
	}

	Future<ProdutoMarca?> getObject(dynamic pk) async {
		return await (select(produtoMarcas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ProdutoMarca?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM produto_marca WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ProdutoMarca;		 
	} 

	Future<ProdutoMarcaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ProdutoMarcaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.produtoMarca = object.produtoMarca!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(produtoMarcas).insert(object.produtoMarca!);
			object.produtoMarca = object.produtoMarca!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ProdutoMarcaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(produtoMarcas).replace(object.produtoMarca!);
		});	 
	} 

	Future<int> deleteObject(ProdutoMarcaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(produtoMarcas).delete(object.produtoMarca!);
		});		
	}

	Future<void> insertChildren(ProdutoMarcaGrouped object) async {
		for (var produtoGrouped in object.produtoGroupedList!) {
			produtoGrouped.produto = produtoGrouped.produto?.copyWith(
				id: const Value(null),
				idProdutoMarca: Value(object.produtoMarca!.id),
			);
			await into(produtos).insert(produtoGrouped.produto!);
		}
	}
	
	Future<void> deleteChildren(ProdutoMarcaGrouped object) async {
		await (delete(produtos)..where((t) => t.idProdutoMarca.equals(object.produtoMarca!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from produto_marca").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}