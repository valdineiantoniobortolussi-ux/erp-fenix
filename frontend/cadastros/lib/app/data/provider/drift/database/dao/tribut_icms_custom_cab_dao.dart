import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'tribut_icms_custom_cab_dao.g.dart';

@DriftAccessor(tables: [
	TributIcmsCustomCabs,
])
class TributIcmsCustomCabDao extends DatabaseAccessor<AppDatabase> with _$TributIcmsCustomCabDaoMixin {
	final AppDatabase db;

	List<TributIcmsCustomCab> tributIcmsCustomCabList = []; 
	List<TributIcmsCustomCabGrouped> tributIcmsCustomCabGroupedList = []; 

	TributIcmsCustomCabDao(this.db) : super(db);

	Future<List<TributIcmsCustomCab>> getList() async {
		tributIcmsCustomCabList = await select(tributIcmsCustomCabs).get();
		return tributIcmsCustomCabList;
	}

	Future<List<TributIcmsCustomCab>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tributIcmsCustomCabList = await (select(tributIcmsCustomCabs)..where((t) => expression)).get();
		return tributIcmsCustomCabList;	 
	}

	Future<List<TributIcmsCustomCabGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tributIcmsCustomCabs)
			.join([]);

		if (field != null && field != '') { 
			final column = tributIcmsCustomCabs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tributIcmsCustomCabGroupedList = await query.map((row) {
			final tributIcmsCustomCab = row.readTableOrNull(tributIcmsCustomCabs); 

			return TributIcmsCustomCabGrouped(
				tributIcmsCustomCab: tributIcmsCustomCab, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var tributIcmsCustomCabGrouped in tributIcmsCustomCabGroupedList) {
		//}		

		return tributIcmsCustomCabGroupedList;	
	}

	Future<TributIcmsCustomCab?> getObject(dynamic pk) async {
		return await (select(tributIcmsCustomCabs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TributIcmsCustomCab?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tribut_icms_custom_cab WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TributIcmsCustomCab;		 
	} 

	Future<TributIcmsCustomCabGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TributIcmsCustomCabGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tributIcmsCustomCab = object.tributIcmsCustomCab!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tributIcmsCustomCabs).insert(object.tributIcmsCustomCab!);
			object.tributIcmsCustomCab = object.tributIcmsCustomCab!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TributIcmsCustomCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tributIcmsCustomCabs).replace(object.tributIcmsCustomCab!);
		});	 
	} 

	Future<int> deleteObject(TributIcmsCustomCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tributIcmsCustomCabs).delete(object.tributIcmsCustomCab!);
		});		
	}

	Future<void> insertChildren(TributIcmsCustomCabGrouped object) async {
	}
	
	Future<void> deleteChildren(TributIcmsCustomCabGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tribut_icms_custom_cab").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}