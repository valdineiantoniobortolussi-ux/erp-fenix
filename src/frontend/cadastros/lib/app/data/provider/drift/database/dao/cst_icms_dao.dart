import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'cst_icms_dao.g.dart';

@DriftAccessor(tables: [
	CstIcmss,
])
class CstIcmsDao extends DatabaseAccessor<AppDatabase> with _$CstIcmsDaoMixin {
	final AppDatabase db;

	List<CstIcms> cstIcmsList = []; 
	List<CstIcmsGrouped> cstIcmsGroupedList = []; 

	CstIcmsDao(this.db) : super(db);

	Future<List<CstIcms>> getList() async {
		cstIcmsList = await select(cstIcmss).get();
		return cstIcmsList;
	}

	Future<List<CstIcms>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cstIcmsList = await (select(cstIcmss)..where((t) => expression)).get();
		return cstIcmsList;	 
	}

	Future<List<CstIcmsGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cstIcmss)
			.join([]);

		if (field != null && field != '') { 
			final column = cstIcmss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cstIcmsGroupedList = await query.map((row) {
			final cstIcms = row.readTableOrNull(cstIcmss); 

			return CstIcmsGrouped(
				cstIcms: cstIcms, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cstIcmsGrouped in cstIcmsGroupedList) {
		//}		

		return cstIcmsGroupedList;	
	}

	Future<CstIcms?> getObject(dynamic pk) async {
		return await (select(cstIcmss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CstIcms?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cst_icms WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CstIcms;		 
	} 

	Future<CstIcmsGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CstIcmsGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cstIcms = object.cstIcms!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cstIcmss).insert(object.cstIcms!);
			object.cstIcms = object.cstIcms!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CstIcmsGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cstIcmss).replace(object.cstIcms!);
		});	 
	} 

	Future<int> deleteObject(CstIcmsGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cstIcmss).delete(object.cstIcms!);
		});		
	}

	Future<void> insertChildren(CstIcmsGrouped object) async {
	}
	
	Future<void> deleteChildren(CstIcmsGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cst_icms").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}