import 'package:drift/drift.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';
import 'package:gondolas/app/data/provider/drift/database/database_imports.dart';

part 'produto_dao.g.dart';

@DriftAccessor(tables: [
	Produtos,
])
class ProdutoDao extends DatabaseAccessor<AppDatabase> with _$ProdutoDaoMixin {
	final AppDatabase db;

	List<Produto> produtoList = []; 
	List<ProdutoGrouped> produtoGroupedList = []; 

	ProdutoDao(this.db) : super(db);

	Future<List<Produto>> getList() async {
		produtoList = await select(produtos).get();
		return produtoList;
	}

	Future<List<Produto>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		produtoList = await (select(produtos)..where((t) => expression)).get();
		return produtoList;	 
	}

	Future<List<ProdutoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(produtos)
			.join([]);

		if (field != null && field != '') { 
			final column = produtos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		produtoGroupedList = await query.map((row) {
			final produto = row.readTableOrNull(produtos); 

			return ProdutoGrouped(
				produto: produto, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var produtoGrouped in produtoGroupedList) {
		//}		

		return produtoGroupedList;	
	}

	Future<Produto?> getObject(dynamic pk) async {
		return await (select(produtos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Produto?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM produto WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Produto;		 
	} 

	Future<ProdutoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ProdutoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.produto = object.produto!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(produtos).insert(object.produto!);
			object.produto = object.produto!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ProdutoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(produtos).replace(object.produto!);
		});	 
	} 

	Future<int> deleteObject(ProdutoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(produtos).delete(object.produto!);
		});		
	}

	Future<void> insertChildren(ProdutoGrouped object) async {
	}
	
	Future<void> deleteChildren(ProdutoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from produto").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}