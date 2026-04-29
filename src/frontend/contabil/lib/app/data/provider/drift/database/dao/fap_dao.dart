import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'fap_dao.g.dart';

@DriftAccessor(tables: [
	Faps,
])
class FapDao extends DatabaseAccessor<AppDatabase> with _$FapDaoMixin {
	final AppDatabase db;

	List<Fap> fapList = []; 
	List<FapGrouped> fapGroupedList = []; 

	FapDao(this.db) : super(db);

	Future<List<Fap>> getList() async {
		fapList = await select(faps).get();
		return fapList;
	}

	Future<List<Fap>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fapList = await (select(faps)..where((t) => expression)).get();
		return fapList;	 
	}

	Future<List<FapGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(faps)
			.join([]);

		if (field != null && field != '') { 
			final column = faps.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fapGroupedList = await query.map((row) {
			final fap = row.readTableOrNull(faps); 

			return FapGrouped(
				fap: fap, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var fapGrouped in fapGroupedList) {
		//}		

		return fapGroupedList;	
	}

	Future<Fap?> getObject(dynamic pk) async {
		return await (select(faps)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Fap?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fap WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Fap;		 
	} 

	Future<FapGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FapGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fap = object.fap!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(faps).insert(object.fap!);
			object.fap = object.fap!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FapGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(faps).replace(object.fap!);
		});	 
	} 

	Future<int> deleteObject(FapGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(faps).delete(object.fap!);
		});		
	}

	Future<void> insertChildren(FapGrouped object) async {
	}
	
	Future<void> deleteChildren(FapGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fap").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}