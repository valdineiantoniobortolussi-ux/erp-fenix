import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'estado_civil_dao.g.dart';

@DriftAccessor(tables: [
	EstadoCivils,
])
class EstadoCivilDao extends DatabaseAccessor<AppDatabase> with _$EstadoCivilDaoMixin {
	final AppDatabase db;

	List<EstadoCivil> estadoCivilList = []; 
	List<EstadoCivilGrouped> estadoCivilGroupedList = []; 

	EstadoCivilDao(this.db) : super(db);

	Future<List<EstadoCivil>> getList() async {
		estadoCivilList = await select(estadoCivils).get();
		return estadoCivilList;
	}

	Future<List<EstadoCivil>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		estadoCivilList = await (select(estadoCivils)..where((t) => expression)).get();
		return estadoCivilList;	 
	}

	Future<List<EstadoCivilGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(estadoCivils)
			.join([]);

		if (field != null && field != '') { 
			final column = estadoCivils.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		estadoCivilGroupedList = await query.map((row) {
			final estadoCivil = row.readTableOrNull(estadoCivils); 

			return EstadoCivilGrouped(
				estadoCivil: estadoCivil, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var estadoCivilGrouped in estadoCivilGroupedList) {
		//}		

		return estadoCivilGroupedList;	
	}

	Future<EstadoCivil?> getObject(dynamic pk) async {
		return await (select(estadoCivils)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EstadoCivil?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM estado_civil WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EstadoCivil;		 
	} 

	Future<EstadoCivilGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EstadoCivilGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.estadoCivil = object.estadoCivil!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(estadoCivils).insert(object.estadoCivil!);
			object.estadoCivil = object.estadoCivil!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EstadoCivilGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(estadoCivils).replace(object.estadoCivil!);
		});	 
	} 

	Future<int> deleteObject(EstadoCivilGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(estadoCivils).delete(object.estadoCivil!);
		});		
	}

	Future<void> insertChildren(EstadoCivilGrouped object) async {
	}
	
	Future<void> deleteChildren(EstadoCivilGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from estado_civil").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}