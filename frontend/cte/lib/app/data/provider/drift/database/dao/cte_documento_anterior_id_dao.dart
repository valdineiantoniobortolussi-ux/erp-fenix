import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_documento_anterior_id_dao.g.dart';

@DriftAccessor(tables: [
	CteDocumentoAnteriorIds,
])
class CteDocumentoAnteriorIdDao extends DatabaseAccessor<AppDatabase> with _$CteDocumentoAnteriorIdDaoMixin {
	final AppDatabase db;

	List<CteDocumentoAnteriorId> cteDocumentoAnteriorIdList = []; 
	List<CteDocumentoAnteriorIdGrouped> cteDocumentoAnteriorIdGroupedList = []; 

	CteDocumentoAnteriorIdDao(this.db) : super(db);

	Future<List<CteDocumentoAnteriorId>> getList() async {
		cteDocumentoAnteriorIdList = await select(cteDocumentoAnteriorIds).get();
		return cteDocumentoAnteriorIdList;
	}

	Future<List<CteDocumentoAnteriorId>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteDocumentoAnteriorIdList = await (select(cteDocumentoAnteriorIds)..where((t) => expression)).get();
		return cteDocumentoAnteriorIdList;	 
	}

	Future<List<CteDocumentoAnteriorIdGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteDocumentoAnteriorIds)
			.join([]);

		if (field != null && field != '') { 
			final column = cteDocumentoAnteriorIds.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteDocumentoAnteriorIdGroupedList = await query.map((row) {
			final cteDocumentoAnteriorId = row.readTableOrNull(cteDocumentoAnteriorIds); 

			return CteDocumentoAnteriorIdGrouped(
				cteDocumentoAnteriorId: cteDocumentoAnteriorId, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteDocumentoAnteriorIdGrouped in cteDocumentoAnteriorIdGroupedList) {
		//}		

		return cteDocumentoAnteriorIdGroupedList;	
	}

	Future<CteDocumentoAnteriorId?> getObject(dynamic pk) async {
		return await (select(cteDocumentoAnteriorIds)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteDocumentoAnteriorId?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_documento_anterior_id WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteDocumentoAnteriorId;		 
	} 

	Future<CteDocumentoAnteriorIdGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteDocumentoAnteriorIdGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteDocumentoAnteriorId = object.cteDocumentoAnteriorId!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteDocumentoAnteriorIds).insert(object.cteDocumentoAnteriorId!);
			object.cteDocumentoAnteriorId = object.cteDocumentoAnteriorId!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteDocumentoAnteriorIdGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteDocumentoAnteriorIds).replace(object.cteDocumentoAnteriorId!);
		});	 
	} 

	Future<int> deleteObject(CteDocumentoAnteriorIdGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteDocumentoAnteriorIds).delete(object.cteDocumentoAnteriorId!);
		});		
	}

	Future<void> insertChildren(CteDocumentoAnteriorIdGrouped object) async {
	}
	
	Future<void> deleteChildren(CteDocumentoAnteriorIdGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_documento_anterior_id").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}