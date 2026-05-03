import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'uf_dao.g.dart';

@DriftAccessor(tables: [
	Ufs,
])
class UfDao extends DatabaseAccessor<AppDatabase> with _$UfDaoMixin {
	final AppDatabase db;

	List<Uf> ufList = []; 
	List<UfGrouped> ufGroupedList = []; 

	UfDao(this.db) : super(db);

	Future<List<Uf>> getList() async {
		ufList = await select(ufs).get();
		return ufList;
	}

	Future<List<Uf>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		ufList = await (select(ufs)..where((t) => expression)).get();
		return ufList;	 
	}

	Future<List<UfGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(ufs)
			.join([]);

		if (field != null && field != '') { 
			final column = ufs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		ufGroupedList = await query.map((row) {
			final uf = row.readTableOrNull(ufs); 

			return UfGrouped(
				uf: uf, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var ufGrouped in ufGroupedList) {
		//}		

		return ufGroupedList;	
	}

	Future<Uf?> getObject(dynamic pk) async {
		return await (select(ufs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Uf?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM uf WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Uf;		 
	} 

	Future<UfGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(UfGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.uf = object.uf!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(ufs).insert(object.uf!);
			object.uf = object.uf!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(UfGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(ufs).replace(object.uf!);
		});	 
	} 

	Future<int> deleteObject(UfGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(ufs).delete(object.uf!);
		});		
	}

	Future<void> insertChildren(UfGrouped object) async {
	}
	
	Future<void> deleteChildren(UfGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from uf").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}