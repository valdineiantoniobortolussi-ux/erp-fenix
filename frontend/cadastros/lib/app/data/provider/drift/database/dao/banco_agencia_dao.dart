import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'banco_agencia_dao.g.dart';

@DriftAccessor(tables: [
	BancoAgencias,
	Bancos,
])
class BancoAgenciaDao extends DatabaseAccessor<AppDatabase> with _$BancoAgenciaDaoMixin {
	final AppDatabase db;

	List<BancoAgencia> bancoAgenciaList = []; 
	List<BancoAgenciaGrouped> bancoAgenciaGroupedList = []; 

	BancoAgenciaDao(this.db) : super(db);

	Future<List<BancoAgencia>> getList() async {
		bancoAgenciaList = await select(bancoAgencias).get();
		return bancoAgenciaList;
	}

	Future<List<BancoAgencia>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		bancoAgenciaList = await (select(bancoAgencias)..where((t) => expression)).get();
		return bancoAgenciaList;	 
	}

	Future<List<BancoAgenciaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(bancoAgencias)
			.join([ 
				leftOuterJoin(bancos, bancos.id.equalsExp(bancoAgencias.idBanco)), 
			]);

		if (field != null && field != '') { 
			final column = bancoAgencias.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		bancoAgenciaGroupedList = await query.map((row) {
			final bancoAgencia = row.readTableOrNull(bancoAgencias); 
			final banco = row.readTableOrNull(bancos); 

			return BancoAgenciaGrouped(
				bancoAgencia: bancoAgencia, 
				banco: banco, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var bancoAgenciaGrouped in bancoAgenciaGroupedList) {
		//}		

		return bancoAgenciaGroupedList;	
	}

	Future<BancoAgencia?> getObject(dynamic pk) async {
		return await (select(bancoAgencias)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<BancoAgencia?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM banco_agencia WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as BancoAgencia;		 
	} 

	Future<BancoAgenciaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(BancoAgenciaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.bancoAgencia = object.bancoAgencia!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(bancoAgencias).insert(object.bancoAgencia!);
			object.bancoAgencia = object.bancoAgencia!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(BancoAgenciaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(bancoAgencias).replace(object.bancoAgencia!);
		});	 
	} 

	Future<int> deleteObject(BancoAgenciaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(bancoAgencias).delete(object.bancoAgencia!);
		});		
	}

	Future<void> insertChildren(BancoAgenciaGrouped object) async {
	}
	
	Future<void> deleteChildren(BancoAgenciaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from banco_agencia").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}