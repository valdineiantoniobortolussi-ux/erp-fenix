import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'csosn_dao.g.dart';

@DriftAccessor(tables: [
	Csosns,
])
class CsosnDao extends DatabaseAccessor<AppDatabase> with _$CsosnDaoMixin {
	final AppDatabase db;

	List<Csosn> csosnList = []; 
	List<CsosnGrouped> csosnGroupedList = []; 

	CsosnDao(this.db) : super(db);

	Future<List<Csosn>> getList() async {
		csosnList = await select(csosns).get();
		return csosnList;
	}

	Future<List<Csosn>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		csosnList = await (select(csosns)..where((t) => expression)).get();
		return csosnList;	 
	}

	Future<List<CsosnGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(csosns)
			.join([]);

		if (field != null && field != '') { 
			final column = csosns.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		csosnGroupedList = await query.map((row) {
			final csosn = row.readTableOrNull(csosns); 

			return CsosnGrouped(
				csosn: csosn, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var csosnGrouped in csosnGroupedList) {
		//}		

		return csosnGroupedList;	
	}

	Future<Csosn?> getObject(dynamic pk) async {
		return await (select(csosns)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Csosn?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM csosn WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Csosn;		 
	} 

	Future<CsosnGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CsosnGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.csosn = object.csosn!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(csosns).insert(object.csosn!);
			object.csosn = object.csosn!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CsosnGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(csosns).replace(object.csosn!);
		});	 
	} 

	Future<int> deleteObject(CsosnGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(csosns).delete(object.csosn!);
		});		
	}

	Future<void> insertChildren(CsosnGrouped object) async {
	}
	
	Future<void> deleteChildren(CsosnGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from csosn").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}