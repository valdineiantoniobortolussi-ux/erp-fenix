import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

part 'wms_estante_dao.g.dart';

@DriftAccessor(tables: [
	WmsEstantes,
	WmsRuas,
])
class WmsEstanteDao extends DatabaseAccessor<AppDatabase> with _$WmsEstanteDaoMixin {
	final AppDatabase db;

	List<WmsEstante> wmsEstanteList = []; 
	List<WmsEstanteGrouped> wmsEstanteGroupedList = []; 

	WmsEstanteDao(this.db) : super(db);

	Future<List<WmsEstante>> getList() async {
		wmsEstanteList = await select(wmsEstantes).get();
		return wmsEstanteList;
	}

	Future<List<WmsEstante>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		wmsEstanteList = await (select(wmsEstantes)..where((t) => expression)).get();
		return wmsEstanteList;	 
	}

	Future<List<WmsEstanteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(wmsEstantes)
			.join([ 
				leftOuterJoin(wmsRuas, wmsRuas.id.equalsExp(wmsEstantes.idWmsRua)), 
			]);

		if (field != null && field != '') { 
			final column = wmsEstantes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		wmsEstanteGroupedList = await query.map((row) {
			final wmsEstante = row.readTableOrNull(wmsEstantes); 
			final wmsRua = row.readTableOrNull(wmsRuas); 

			return WmsEstanteGrouped(
				wmsEstante: wmsEstante, 
				wmsRua: wmsRua, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var wmsEstanteGrouped in wmsEstanteGroupedList) {
		//}		

		return wmsEstanteGroupedList;	
	}

	Future<WmsEstante?> getObject(dynamic pk) async {
		return await (select(wmsEstantes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<WmsEstante?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM wms_estante WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as WmsEstante;		 
	} 

	Future<WmsEstanteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(WmsEstanteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.wmsEstante = object.wmsEstante!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(wmsEstantes).insert(object.wmsEstante!);
			object.wmsEstante = object.wmsEstante!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(WmsEstanteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(wmsEstantes).replace(object.wmsEstante!);
		});	 
	} 

	Future<int> deleteObject(WmsEstanteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(wmsEstantes).delete(object.wmsEstante!);
		});		
	}

	Future<void> insertChildren(WmsEstanteGrouped object) async {
	}
	
	Future<void> deleteChildren(WmsEstanteGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from wms_estante").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}