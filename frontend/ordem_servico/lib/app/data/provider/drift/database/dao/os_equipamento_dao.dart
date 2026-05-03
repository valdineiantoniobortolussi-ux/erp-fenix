import 'package:drift/drift.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database_imports.dart';

part 'os_equipamento_dao.g.dart';

@DriftAccessor(tables: [
	OsEquipamentos,
])
class OsEquipamentoDao extends DatabaseAccessor<AppDatabase> with _$OsEquipamentoDaoMixin {
	final AppDatabase db;

	List<OsEquipamento> osEquipamentoList = []; 
	List<OsEquipamentoGrouped> osEquipamentoGroupedList = []; 

	OsEquipamentoDao(this.db) : super(db);

	Future<List<OsEquipamento>> getList() async {
		osEquipamentoList = await select(osEquipamentos).get();
		return osEquipamentoList;
	}

	Future<List<OsEquipamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		osEquipamentoList = await (select(osEquipamentos)..where((t) => expression)).get();
		return osEquipamentoList;	 
	}

	Future<List<OsEquipamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(osEquipamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = osEquipamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		osEquipamentoGroupedList = await query.map((row) {
			final osEquipamento = row.readTableOrNull(osEquipamentos); 

			return OsEquipamentoGrouped(
				osEquipamento: osEquipamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var osEquipamentoGrouped in osEquipamentoGroupedList) {
		//}		

		return osEquipamentoGroupedList;	
	}

	Future<OsEquipamento?> getObject(dynamic pk) async {
		return await (select(osEquipamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<OsEquipamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM os_equipamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as OsEquipamento;		 
	} 

	Future<OsEquipamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(OsEquipamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.osEquipamento = object.osEquipamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(osEquipamentos).insert(object.osEquipamento!);
			object.osEquipamento = object.osEquipamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(OsEquipamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(osEquipamentos).replace(object.osEquipamento!);
		});	 
	} 

	Future<int> deleteObject(OsEquipamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(osEquipamentos).delete(object.osEquipamento!);
		});		
	}

	Future<void> insertChildren(OsEquipamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(OsEquipamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from os_equipamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}