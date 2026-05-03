import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

part 'wms_rua_dao.g.dart';

@DriftAccessor(tables: [
	WmsRuas,
])
class WmsRuaDao extends DatabaseAccessor<AppDatabase> with _$WmsRuaDaoMixin {
	final AppDatabase db;

	List<WmsRua> wmsRuaList = []; 
	List<WmsRuaGrouped> wmsRuaGroupedList = []; 

	WmsRuaDao(this.db) : super(db);

	Future<List<WmsRua>> getList() async {
		wmsRuaList = await select(wmsRuas).get();
		return wmsRuaList;
	}

	Future<List<WmsRua>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		wmsRuaList = await (select(wmsRuas)..where((t) => expression)).get();
		return wmsRuaList;	 
	}

	Future<List<WmsRuaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(wmsRuas)
			.join([]);

		if (field != null && field != '') { 
			final column = wmsRuas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		wmsRuaGroupedList = await query.map((row) {
			final wmsRua = row.readTableOrNull(wmsRuas); 

			return WmsRuaGrouped(
				wmsRua: wmsRua, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var wmsRuaGrouped in wmsRuaGroupedList) {
		//}		

		return wmsRuaGroupedList;	
	}

	Future<WmsRua?> getObject(dynamic pk) async {
		return await (select(wmsRuas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<WmsRua?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM wms_rua WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as WmsRua;		 
	} 

	Future<WmsRuaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(WmsRuaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.wmsRua = object.wmsRua!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(wmsRuas).insert(object.wmsRua!);
			object.wmsRua = object.wmsRua!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(WmsRuaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(wmsRuas).replace(object.wmsRua!);
		});	 
	} 

	Future<int> deleteObject(WmsRuaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(wmsRuas).delete(object.wmsRua!);
		});		
	}

	Future<void> insertChildren(WmsRuaGrouped object) async {
	}
	
	Future<void> deleteChildren(WmsRuaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from wms_rua").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}