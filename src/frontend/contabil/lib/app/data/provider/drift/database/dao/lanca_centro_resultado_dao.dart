import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'lanca_centro_resultado_dao.g.dart';

@DriftAccessor(tables: [
	LancaCentroResultados,
	CentroResultados,
])
class LancaCentroResultadoDao extends DatabaseAccessor<AppDatabase> with _$LancaCentroResultadoDaoMixin {
	final AppDatabase db;

	List<LancaCentroResultado> lancaCentroResultadoList = []; 
	List<LancaCentroResultadoGrouped> lancaCentroResultadoGroupedList = []; 

	LancaCentroResultadoDao(this.db) : super(db);

	Future<List<LancaCentroResultado>> getList() async {
		lancaCentroResultadoList = await select(lancaCentroResultados).get();
		return lancaCentroResultadoList;
	}

	Future<List<LancaCentroResultado>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		lancaCentroResultadoList = await (select(lancaCentroResultados)..where((t) => expression)).get();
		return lancaCentroResultadoList;	 
	}

	Future<List<LancaCentroResultadoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(lancaCentroResultados)
			.join([ 
				leftOuterJoin(centroResultados, centroResultados.id.equalsExp(lancaCentroResultados.idCentroResultado)), 
			]);

		if (field != null && field != '') { 
			final column = lancaCentroResultados.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		lancaCentroResultadoGroupedList = await query.map((row) {
			final lancaCentroResultado = row.readTableOrNull(lancaCentroResultados); 
			final centroResultado = row.readTableOrNull(centroResultados); 

			return LancaCentroResultadoGrouped(
				lancaCentroResultado: lancaCentroResultado, 
				centroResultado: centroResultado, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var lancaCentroResultadoGrouped in lancaCentroResultadoGroupedList) {
		//}		

		return lancaCentroResultadoGroupedList;	
	}

	Future<LancaCentroResultado?> getObject(dynamic pk) async {
		return await (select(lancaCentroResultados)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<LancaCentroResultado?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM lanca_centro_resultado WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as LancaCentroResultado;		 
	} 

	Future<LancaCentroResultadoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(LancaCentroResultadoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.lancaCentroResultado = object.lancaCentroResultado!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(lancaCentroResultados).insert(object.lancaCentroResultado!);
			object.lancaCentroResultado = object.lancaCentroResultado!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(LancaCentroResultadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(lancaCentroResultados).replace(object.lancaCentroResultado!);
		});	 
	} 

	Future<int> deleteObject(LancaCentroResultadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(lancaCentroResultados).delete(object.lancaCentroResultado!);
		});		
	}

	Future<void> insertChildren(LancaCentroResultadoGrouped object) async {
	}
	
	Future<void> deleteChildren(LancaCentroResultadoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from lanca_centro_resultado").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}