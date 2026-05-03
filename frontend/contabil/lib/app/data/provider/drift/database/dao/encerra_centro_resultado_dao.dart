import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'encerra_centro_resultado_dao.g.dart';

@DriftAccessor(tables: [
	EncerraCentroResultados,
	CentroResultados,
])
class EncerraCentroResultadoDao extends DatabaseAccessor<AppDatabase> with _$EncerraCentroResultadoDaoMixin {
	final AppDatabase db;

	List<EncerraCentroResultado> encerraCentroResultadoList = []; 
	List<EncerraCentroResultadoGrouped> encerraCentroResultadoGroupedList = []; 

	EncerraCentroResultadoDao(this.db) : super(db);

	Future<List<EncerraCentroResultado>> getList() async {
		encerraCentroResultadoList = await select(encerraCentroResultados).get();
		return encerraCentroResultadoList;
	}

	Future<List<EncerraCentroResultado>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		encerraCentroResultadoList = await (select(encerraCentroResultados)..where((t) => expression)).get();
		return encerraCentroResultadoList;	 
	}

	Future<List<EncerraCentroResultadoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(encerraCentroResultados)
			.join([ 
				leftOuterJoin(centroResultados, centroResultados.id.equalsExp(encerraCentroResultados.idCentroResultado)), 
			]);

		if (field != null && field != '') { 
			final column = encerraCentroResultados.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		encerraCentroResultadoGroupedList = await query.map((row) {
			final encerraCentroResultado = row.readTableOrNull(encerraCentroResultados); 
			final centroResultado = row.readTableOrNull(centroResultados); 

			return EncerraCentroResultadoGrouped(
				encerraCentroResultado: encerraCentroResultado, 
				centroResultado: centroResultado, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var encerraCentroResultadoGrouped in encerraCentroResultadoGroupedList) {
		//}		

		return encerraCentroResultadoGroupedList;	
	}

	Future<EncerraCentroResultado?> getObject(dynamic pk) async {
		return await (select(encerraCentroResultados)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EncerraCentroResultado?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM encerra_centro_resultado WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EncerraCentroResultado;		 
	} 

	Future<EncerraCentroResultadoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EncerraCentroResultadoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.encerraCentroResultado = object.encerraCentroResultado!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(encerraCentroResultados).insert(object.encerraCentroResultado!);
			object.encerraCentroResultado = object.encerraCentroResultado!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EncerraCentroResultadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(encerraCentroResultados).replace(object.encerraCentroResultado!);
		});	 
	} 

	Future<int> deleteObject(EncerraCentroResultadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(encerraCentroResultados).delete(object.encerraCentroResultado!);
		});		
	}

	Future<void> insertChildren(EncerraCentroResultadoGrouped object) async {
	}
	
	Future<void> deleteChildren(EncerraCentroResultadoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from encerra_centro_resultado").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}