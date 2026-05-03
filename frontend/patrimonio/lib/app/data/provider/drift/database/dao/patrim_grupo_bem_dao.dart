import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'patrim_grupo_bem_dao.g.dart';

@DriftAccessor(tables: [
	PatrimGrupoBems,
])
class PatrimGrupoBemDao extends DatabaseAccessor<AppDatabase> with _$PatrimGrupoBemDaoMixin {
	final AppDatabase db;

	List<PatrimGrupoBem> patrimGrupoBemList = []; 
	List<PatrimGrupoBemGrouped> patrimGrupoBemGroupedList = []; 

	PatrimGrupoBemDao(this.db) : super(db);

	Future<List<PatrimGrupoBem>> getList() async {
		patrimGrupoBemList = await select(patrimGrupoBems).get();
		return patrimGrupoBemList;
	}

	Future<List<PatrimGrupoBem>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		patrimGrupoBemList = await (select(patrimGrupoBems)..where((t) => expression)).get();
		return patrimGrupoBemList;	 
	}

	Future<List<PatrimGrupoBemGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(patrimGrupoBems)
			.join([]);

		if (field != null && field != '') { 
			final column = patrimGrupoBems.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		patrimGrupoBemGroupedList = await query.map((row) {
			final patrimGrupoBem = row.readTableOrNull(patrimGrupoBems); 

			return PatrimGrupoBemGrouped(
				patrimGrupoBem: patrimGrupoBem, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var patrimGrupoBemGrouped in patrimGrupoBemGroupedList) {
		//}		

		return patrimGrupoBemGroupedList;	
	}

	Future<PatrimGrupoBem?> getObject(dynamic pk) async {
		return await (select(patrimGrupoBems)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PatrimGrupoBem?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM patrim_grupo_bem WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PatrimGrupoBem;		 
	} 

	Future<PatrimGrupoBemGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PatrimGrupoBemGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.patrimGrupoBem = object.patrimGrupoBem!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(patrimGrupoBems).insert(object.patrimGrupoBem!);
			object.patrimGrupoBem = object.patrimGrupoBem!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PatrimGrupoBemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(patrimGrupoBems).replace(object.patrimGrupoBem!);
		});	 
	} 

	Future<int> deleteObject(PatrimGrupoBemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(patrimGrupoBems).delete(object.patrimGrupoBem!);
		});		
	}

	Future<void> insertChildren(PatrimGrupoBemGrouped object) async {
	}
	
	Future<void> deleteChildren(PatrimGrupoBemGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from patrim_grupo_bem").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}