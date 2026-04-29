import 'package:drift/drift.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/provider/drift/database/database_imports.dart';

part 'efd_reinf_dao.g.dart';

@DriftAccessor(tables: [
	EfdReinfs,
])
class EfdReinfDao extends DatabaseAccessor<AppDatabase> with _$EfdReinfDaoMixin {
	final AppDatabase db;

	List<EfdReinf> efdReinfList = []; 
	List<EfdReinfGrouped> efdReinfGroupedList = []; 

	EfdReinfDao(this.db) : super(db);

	Future<List<EfdReinf>> getList() async {
		efdReinfList = await select(efdReinfs).get();
		return efdReinfList;
	}

	Future<List<EfdReinf>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		efdReinfList = await (select(efdReinfs)..where((t) => expression)).get();
		return efdReinfList;	 
	}

	Future<List<EfdReinfGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(efdReinfs)
			.join([]);

		if (field != null && field != '') { 
			final column = efdReinfs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		efdReinfGroupedList = await query.map((row) {
			final efdReinf = row.readTableOrNull(efdReinfs); 

			return EfdReinfGrouped(
				efdReinf: efdReinf, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var efdReinfGrouped in efdReinfGroupedList) {
		//}		

		return efdReinfGroupedList;	
	}

	Future<EfdReinf?> getObject(dynamic pk) async {
		return await (select(efdReinfs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EfdReinf?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM efd_reinf WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EfdReinf;		 
	} 

	Future<EfdReinfGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EfdReinfGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.efdReinf = object.efdReinf!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(efdReinfs).insert(object.efdReinf!);
			object.efdReinf = object.efdReinf!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EfdReinfGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(efdReinfs).replace(object.efdReinf!);
		});	 
	} 

	Future<int> deleteObject(EfdReinfGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(efdReinfs).delete(object.efdReinf!);
		});		
	}

	Future<void> insertChildren(EfdReinfGrouped object) async {
	}
	
	Future<void> deleteChildren(EfdReinfGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from efd_reinf").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}