import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'banco_dao.g.dart';

@DriftAccessor(tables: [
	Bancos,
])
class BancoDao extends DatabaseAccessor<AppDatabase> with _$BancoDaoMixin {
	final AppDatabase db;

	List<Banco> bancoList = []; 
	List<BancoGrouped> bancoGroupedList = []; 

	BancoDao(this.db) : super(db);

	Future<List<Banco>> getList() async {
		bancoList = await select(bancos).get();
		return bancoList;
	}

	Future<List<Banco>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		bancoList = await (select(bancos)..where((t) => expression)).get();
		return bancoList;	 
	}

	Future<List<BancoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(bancos)
			.join([]);

		if (field != null && field != '') { 
			final column = bancos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		bancoGroupedList = await query.map((row) {
			final banco = row.readTableOrNull(bancos); 

			return BancoGrouped(
				banco: banco, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var bancoGrouped in bancoGroupedList) {
		//}		

		return bancoGroupedList;	
	}

	Future<Banco?> getObject(dynamic pk) async {
		return await (select(bancos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Banco?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM banco WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Banco;		 
	} 

	Future<BancoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(BancoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.banco = object.banco!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(bancos).insert(object.banco!);
			object.banco = object.banco!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(BancoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(bancos).replace(object.banco!);
		});	 
	} 

	Future<int> deleteObject(BancoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(bancos).delete(object.banco!);
		});		
	}

	Future<void> insertChildren(BancoGrouped object) async {
	}
	
	Future<void> deleteChildren(BancoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from banco").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}