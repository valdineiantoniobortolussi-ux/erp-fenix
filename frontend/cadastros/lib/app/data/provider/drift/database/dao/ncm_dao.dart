import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'ncm_dao.g.dart';

@DriftAccessor(tables: [
	Ncms,
])
class NcmDao extends DatabaseAccessor<AppDatabase> with _$NcmDaoMixin {
	final AppDatabase db;

	List<Ncm> ncmList = []; 
	List<NcmGrouped> ncmGroupedList = []; 

	NcmDao(this.db) : super(db);

	Future<List<Ncm>> getList() async {
		ncmList = await select(ncms).get();
		return ncmList;
	}

	Future<List<Ncm>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		ncmList = await (select(ncms)..where((t) => expression)).get();
		return ncmList;	 
	}

	Future<List<NcmGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(ncms)
			.join([]);

		if (field != null && field != '') { 
			final column = ncms.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		ncmGroupedList = await query.map((row) {
			final ncm = row.readTableOrNull(ncms); 

			return NcmGrouped(
				ncm: ncm, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var ncmGrouped in ncmGroupedList) {
		//}		

		return ncmGroupedList;	
	}

	Future<Ncm?> getObject(dynamic pk) async {
		return await (select(ncms)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Ncm?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ncm WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Ncm;		 
	} 

	Future<NcmGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NcmGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.ncm = object.ncm!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(ncms).insert(object.ncm!);
			object.ncm = object.ncm!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NcmGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(ncms).replace(object.ncm!);
		});	 
	} 

	Future<int> deleteObject(NcmGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(ncms).delete(object.ncm!);
		});		
	}

	Future<void> insertChildren(NcmGrouped object) async {
	}
	
	Future<void> deleteChildren(NcmGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ncm").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}