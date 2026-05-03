import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

part 'wms_parametro_dao.g.dart';

@DriftAccessor(tables: [
	WmsParametros,
])
class WmsParametroDao extends DatabaseAccessor<AppDatabase> with _$WmsParametroDaoMixin {
	final AppDatabase db;

	List<WmsParametro> wmsParametroList = []; 
	List<WmsParametroGrouped> wmsParametroGroupedList = []; 

	WmsParametroDao(this.db) : super(db);

	Future<List<WmsParametro>> getList() async {
		wmsParametroList = await select(wmsParametros).get();
		return wmsParametroList;
	}

	Future<List<WmsParametro>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		wmsParametroList = await (select(wmsParametros)..where((t) => expression)).get();
		return wmsParametroList;	 
	}

	Future<List<WmsParametroGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(wmsParametros)
			.join([]);

		if (field != null && field != '') { 
			final column = wmsParametros.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		wmsParametroGroupedList = await query.map((row) {
			final wmsParametro = row.readTableOrNull(wmsParametros); 

			return WmsParametroGrouped(
				wmsParametro: wmsParametro, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var wmsParametroGrouped in wmsParametroGroupedList) {
		//}		

		return wmsParametroGroupedList;	
	}

	Future<WmsParametro?> getObject(dynamic pk) async {
		return await (select(wmsParametros)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<WmsParametro?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM wms_parametro WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as WmsParametro;		 
	} 

	Future<WmsParametroGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(WmsParametroGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.wmsParametro = object.wmsParametro!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(wmsParametros).insert(object.wmsParametro!);
			object.wmsParametro = object.wmsParametro!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(WmsParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(wmsParametros).replace(object.wmsParametro!);
		});	 
	} 

	Future<int> deleteObject(WmsParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(wmsParametros).delete(object.wmsParametro!);
		});		
	}

	Future<void> insertChildren(WmsParametroGrouped object) async {
	}
	
	Future<void> deleteChildren(WmsParametroGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from wms_parametro").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}