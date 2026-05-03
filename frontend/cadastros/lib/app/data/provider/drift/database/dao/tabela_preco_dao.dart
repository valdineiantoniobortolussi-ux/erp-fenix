import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'tabela_preco_dao.g.dart';

@DriftAccessor(tables: [
	TabelaPrecos,
])
class TabelaPrecoDao extends DatabaseAccessor<AppDatabase> with _$TabelaPrecoDaoMixin {
	final AppDatabase db;

	List<TabelaPreco> tabelaPrecoList = []; 
	List<TabelaPrecoGrouped> tabelaPrecoGroupedList = []; 

	TabelaPrecoDao(this.db) : super(db);

	Future<List<TabelaPreco>> getList() async {
		tabelaPrecoList = await select(tabelaPrecos).get();
		return tabelaPrecoList;
	}

	Future<List<TabelaPreco>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tabelaPrecoList = await (select(tabelaPrecos)..where((t) => expression)).get();
		return tabelaPrecoList;	 
	}

	Future<List<TabelaPrecoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tabelaPrecos)
			.join([]);

		if (field != null && field != '') { 
			final column = tabelaPrecos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tabelaPrecoGroupedList = await query.map((row) {
			final tabelaPreco = row.readTableOrNull(tabelaPrecos); 

			return TabelaPrecoGrouped(
				tabelaPreco: tabelaPreco, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var tabelaPrecoGrouped in tabelaPrecoGroupedList) {
		//}		

		return tabelaPrecoGroupedList;	
	}

	Future<TabelaPreco?> getObject(dynamic pk) async {
		return await (select(tabelaPrecos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TabelaPreco?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tabela_preco WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TabelaPreco;		 
	} 

	Future<TabelaPrecoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TabelaPrecoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tabelaPreco = object.tabelaPreco!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tabelaPrecos).insert(object.tabelaPreco!);
			object.tabelaPreco = object.tabelaPreco!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TabelaPrecoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tabelaPrecos).replace(object.tabelaPreco!);
		});	 
	} 

	Future<int> deleteObject(TabelaPrecoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tabelaPrecos).delete(object.tabelaPreco!);
		});		
	}

	Future<void> insertChildren(TabelaPrecoGrouped object) async {
	}
	
	Future<void> deleteChildren(TabelaPrecoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tabela_preco").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}