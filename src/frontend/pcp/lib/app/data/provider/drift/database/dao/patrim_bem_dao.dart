import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/provider/drift/database/database_imports.dart';

part 'patrim_bem_dao.g.dart';

@DriftAccessor(tables: [
	PatrimBems,
])
class PatrimBemDao extends DatabaseAccessor<AppDatabase> with _$PatrimBemDaoMixin {
	final AppDatabase db;

	List<PatrimBem> patrimBemList = []; 
	List<PatrimBemGrouped> patrimBemGroupedList = []; 

	PatrimBemDao(this.db) : super(db);

	Future<List<PatrimBem>> getList() async {
		patrimBemList = await select(patrimBems).get();
		return patrimBemList;
	}

	Future<List<PatrimBem>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		patrimBemList = await (select(patrimBems)..where((t) => expression)).get();
		return patrimBemList;	 
	}

	Future<List<PatrimBemGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(patrimBems)
			.join([]);

		if (field != null && field != '') { 
			final column = patrimBems.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		patrimBemGroupedList = await query.map((row) {
			final patrimBem = row.readTableOrNull(patrimBems); 

			return PatrimBemGrouped(
				patrimBem: patrimBem, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var patrimBemGrouped in patrimBemGroupedList) {
		//}		

		return patrimBemGroupedList;	
	}

	Future<PatrimBem?> getObject(dynamic pk) async {
		return await (select(patrimBems)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PatrimBem?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM patrim_bem WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PatrimBem;		 
	} 

	Future<PatrimBemGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PatrimBemGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.patrimBem = object.patrimBem!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(patrimBems).insert(object.patrimBem!);
			object.patrimBem = object.patrimBem!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PatrimBemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(patrimBems).replace(object.patrimBem!);
		});	 
	} 

	Future<int> deleteObject(PatrimBemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(patrimBems).delete(object.patrimBem!);
		});		
	}

	Future<void> insertChildren(PatrimBemGrouped object) async {
	}
	
	Future<void> deleteChildren(PatrimBemGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from patrim_bem").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}