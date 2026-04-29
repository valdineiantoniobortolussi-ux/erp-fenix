import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'feriados_dao.g.dart';

@DriftAccessor(tables: [
	Feriadoss,
])
class FeriadosDao extends DatabaseAccessor<AppDatabase> with _$FeriadosDaoMixin {
	final AppDatabase db;

	List<Feriados> feriadosList = []; 
	List<FeriadosGrouped> feriadosGroupedList = []; 

	FeriadosDao(this.db) : super(db);

	Future<List<Feriados>> getList() async {
		feriadosList = await select(feriadoss).get();
		return feriadosList;
	}

	Future<List<Feriados>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		feriadosList = await (select(feriadoss)..where((t) => expression)).get();
		return feriadosList;	 
	}

	Future<List<FeriadosGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(feriadoss)
			.join([]);

		if (field != null && field != '') { 
			final column = feriadoss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		feriadosGroupedList = await query.map((row) {
			final feriados = row.readTableOrNull(feriadoss); 

			return FeriadosGrouped(
				feriados: feriados, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var feriadosGrouped in feriadosGroupedList) {
		//}		

		return feriadosGroupedList;	
	}

	Future<Feriados?> getObject(dynamic pk) async {
		return await (select(feriadoss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Feriados?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM feriados WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Feriados;		 
	} 

	Future<FeriadosGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FeriadosGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.feriados = object.feriados!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(feriadoss).insert(object.feriados!);
			object.feriados = object.feriados!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FeriadosGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(feriadoss).replace(object.feriados!);
		});	 
	} 

	Future<int> deleteObject(FeriadosGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(feriadoss).delete(object.feriados!);
		});		
	}

	Future<void> insertChildren(FeriadosGrouped object) async {
	}
	
	Future<void> deleteChildren(FeriadosGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from feriados").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}