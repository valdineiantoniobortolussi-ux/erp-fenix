import 'package:drift/drift.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/provider/drift/database/database_imports.dart';

part 'sped_contabil_dao.g.dart';

@DriftAccessor(tables: [
	SpedContabils,
])
class SpedContabilDao extends DatabaseAccessor<AppDatabase> with _$SpedContabilDaoMixin {
	final AppDatabase db;

	List<SpedContabil> spedContabilList = []; 
	List<SpedContabilGrouped> spedContabilGroupedList = []; 

	SpedContabilDao(this.db) : super(db);

	Future<List<SpedContabil>> getList() async {
		spedContabilList = await select(spedContabils).get();
		return spedContabilList;
	}

	Future<List<SpedContabil>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		spedContabilList = await (select(spedContabils)..where((t) => expression)).get();
		return spedContabilList;	 
	}

	Future<List<SpedContabilGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(spedContabils)
			.join([]);

		if (field != null && field != '') { 
			final column = spedContabils.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		spedContabilGroupedList = await query.map((row) {
			final spedContabil = row.readTableOrNull(spedContabils); 

			return SpedContabilGrouped(
				spedContabil: spedContabil, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var spedContabilGrouped in spedContabilGroupedList) {
		//}		

		return spedContabilGroupedList;	
	}

	Future<SpedContabil?> getObject(dynamic pk) async {
		return await (select(spedContabils)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<SpedContabil?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM sped_contabil WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as SpedContabil;		 
	} 

	Future<SpedContabilGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(SpedContabilGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.spedContabil = object.spedContabil!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(spedContabils).insert(object.spedContabil!);
			object.spedContabil = object.spedContabil!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(SpedContabilGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(spedContabils).replace(object.spedContabil!);
		});	 
	} 

	Future<int> deleteObject(SpedContabilGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(spedContabils).delete(object.spedContabil!);
		});		
	}

	Future<void> insertChildren(SpedContabilGrouped object) async {
	}
	
	Future<void> deleteChildren(SpedContabilGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from sped_contabil").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}