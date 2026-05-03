import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_rodoviario_occ_dao.g.dart';

@DriftAccessor(tables: [
	CteRodoviarioOccs,
	CteRodoviarios,
])
class CteRodoviarioOccDao extends DatabaseAccessor<AppDatabase> with _$CteRodoviarioOccDaoMixin {
	final AppDatabase db;

	List<CteRodoviarioOcc> cteRodoviarioOccList = []; 
	List<CteRodoviarioOccGrouped> cteRodoviarioOccGroupedList = []; 

	CteRodoviarioOccDao(this.db) : super(db);

	Future<List<CteRodoviarioOcc>> getList() async {
		cteRodoviarioOccList = await select(cteRodoviarioOccs).get();
		return cteRodoviarioOccList;
	}

	Future<List<CteRodoviarioOcc>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteRodoviarioOccList = await (select(cteRodoviarioOccs)..where((t) => expression)).get();
		return cteRodoviarioOccList;	 
	}

	Future<List<CteRodoviarioOccGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteRodoviarioOccs)
			.join([ 
				leftOuterJoin(cteRodoviarios, cteRodoviarios.id.equalsExp(cteRodoviarioOccs.idCteRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = cteRodoviarioOccs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteRodoviarioOccGroupedList = await query.map((row) {
			final cteRodoviarioOcc = row.readTableOrNull(cteRodoviarioOccs); 
			final cteRodoviario = row.readTableOrNull(cteRodoviarios); 

			return CteRodoviarioOccGrouped(
				cteRodoviarioOcc: cteRodoviarioOcc, 
				cteRodoviario: cteRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteRodoviarioOccGrouped in cteRodoviarioOccGroupedList) {
		//}		

		return cteRodoviarioOccGroupedList;	
	}

	Future<CteRodoviarioOcc?> getObject(dynamic pk) async {
		return await (select(cteRodoviarioOccs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteRodoviarioOcc?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_rodoviario_occ WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteRodoviarioOcc;		 
	} 

	Future<CteRodoviarioOccGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteRodoviarioOccGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteRodoviarioOcc = object.cteRodoviarioOcc!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteRodoviarioOccs).insert(object.cteRodoviarioOcc!);
			object.cteRodoviarioOcc = object.cteRodoviarioOcc!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteRodoviarioOccGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteRodoviarioOccs).replace(object.cteRodoviarioOcc!);
		});	 
	} 

	Future<int> deleteObject(CteRodoviarioOccGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteRodoviarioOccs).delete(object.cteRodoviarioOcc!);
		});		
	}

	Future<void> insertChildren(CteRodoviarioOccGrouped object) async {
	}
	
	Future<void> deleteChildren(CteRodoviarioOccGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_rodoviario_occ").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}