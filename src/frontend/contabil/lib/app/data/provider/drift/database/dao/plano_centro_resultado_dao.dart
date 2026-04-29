import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'plano_centro_resultado_dao.g.dart';

@DriftAccessor(tables: [
	PlanoCentroResultados,
])
class PlanoCentroResultadoDao extends DatabaseAccessor<AppDatabase> with _$PlanoCentroResultadoDaoMixin {
	final AppDatabase db;

	List<PlanoCentroResultado> planoCentroResultadoList = []; 
	List<PlanoCentroResultadoGrouped> planoCentroResultadoGroupedList = []; 

	PlanoCentroResultadoDao(this.db) : super(db);

	Future<List<PlanoCentroResultado>> getList() async {
		planoCentroResultadoList = await select(planoCentroResultados).get();
		return planoCentroResultadoList;
	}

	Future<List<PlanoCentroResultado>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		planoCentroResultadoList = await (select(planoCentroResultados)..where((t) => expression)).get();
		return planoCentroResultadoList;	 
	}

	Future<List<PlanoCentroResultadoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(planoCentroResultados)
			.join([]);

		if (field != null && field != '') { 
			final column = planoCentroResultados.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		planoCentroResultadoGroupedList = await query.map((row) {
			final planoCentroResultado = row.readTableOrNull(planoCentroResultados); 

			return PlanoCentroResultadoGrouped(
				planoCentroResultado: planoCentroResultado, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var planoCentroResultadoGrouped in planoCentroResultadoGroupedList) {
		//}		

		return planoCentroResultadoGroupedList;	
	}

	Future<PlanoCentroResultado?> getObject(dynamic pk) async {
		return await (select(planoCentroResultados)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PlanoCentroResultado?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM plano_centro_resultado WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PlanoCentroResultado;		 
	} 

	Future<PlanoCentroResultadoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PlanoCentroResultadoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.planoCentroResultado = object.planoCentroResultado!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(planoCentroResultados).insert(object.planoCentroResultado!);
			object.planoCentroResultado = object.planoCentroResultado!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PlanoCentroResultadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(planoCentroResultados).replace(object.planoCentroResultado!);
		});	 
	} 

	Future<int> deleteObject(PlanoCentroResultadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(planoCentroResultados).delete(object.planoCentroResultado!);
		});		
	}

	Future<void> insertChildren(PlanoCentroResultadoGrouped object) async {
	}
	
	Future<void> deleteChildren(PlanoCentroResultadoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from plano_centro_resultado").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}