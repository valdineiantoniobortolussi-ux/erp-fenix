import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'produto_unidade_dao.g.dart';

@DriftAccessor(tables: [
	ProdutoUnidades,
	Produtos,
])
class ProdutoUnidadeDao extends DatabaseAccessor<AppDatabase> with _$ProdutoUnidadeDaoMixin {
	final AppDatabase db;

	List<ProdutoUnidade> produtoUnidadeList = []; 
	List<ProdutoUnidadeGrouped> produtoUnidadeGroupedList = []; 

	ProdutoUnidadeDao(this.db) : super(db);

	Future<List<ProdutoUnidade>> getList() async {
		produtoUnidadeList = await select(produtoUnidades).get();
		return produtoUnidadeList;
	}

	Future<List<ProdutoUnidade>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		produtoUnidadeList = await (select(produtoUnidades)..where((t) => expression)).get();
		return produtoUnidadeList;	 
	}

	Future<List<ProdutoUnidadeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(produtoUnidades)
			.join([]);

		if (field != null && field != '') { 
			final column = produtoUnidades.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		produtoUnidadeGroupedList = await query.map((row) {
			final produtoUnidade = row.readTableOrNull(produtoUnidades); 

			return ProdutoUnidadeGrouped(
				produtoUnidade: produtoUnidade, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var produtoUnidadeGrouped in produtoUnidadeGroupedList) {
			produtoUnidadeGrouped.produtoGroupedList = [];
			final queryProduto = ' id_produto_unidade = ${produtoUnidadeGrouped.produtoUnidade!.id}';
			expression = CustomExpression<bool>(queryProduto);
			final produtoList = await (select(produtos)..where((t) => expression)).get();
			for (var produto in produtoList) {
				ProdutoGrouped produtoGrouped = ProdutoGrouped(
					produto: produto,
				);
				produtoUnidadeGrouped.produtoGroupedList!.add(produtoGrouped);
			}

		}		

		return produtoUnidadeGroupedList;	
	}

	Future<ProdutoUnidade?> getObject(dynamic pk) async {
		return await (select(produtoUnidades)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ProdutoUnidade?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM produto_unidade WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ProdutoUnidade;		 
	} 

	Future<ProdutoUnidadeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ProdutoUnidadeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.produtoUnidade = object.produtoUnidade!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(produtoUnidades).insert(object.produtoUnidade!);
			object.produtoUnidade = object.produtoUnidade!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ProdutoUnidadeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(produtoUnidades).replace(object.produtoUnidade!);
		});	 
	} 

	Future<int> deleteObject(ProdutoUnidadeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(produtoUnidades).delete(object.produtoUnidade!);
		});		
	}

	Future<void> insertChildren(ProdutoUnidadeGrouped object) async {
		for (var produtoGrouped in object.produtoGroupedList!) {
			produtoGrouped.produto = produtoGrouped.produto?.copyWith(
				id: const Value(null),
				idProdutoUnidade: Value(object.produtoUnidade!.id),
			);
			await into(produtos).insert(produtoGrouped.produto!);
		}
	}
	
	Future<void> deleteChildren(ProdutoUnidadeGrouped object) async {
		await (delete(produtos)..where((t) => t.idProdutoUnidade.equals(object.produtoUnidade!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from produto_unidade").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}