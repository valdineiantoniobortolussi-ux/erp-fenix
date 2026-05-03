import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'centro_resultado_dao.g.dart';

@DriftAccessor(tables: [
	CentroResultados,
])
class CentroResultadoDao extends DatabaseAccessor<AppDatabase> with _$CentroResultadoDaoMixin {
	final AppDatabase db;

	List<CentroResultado> centroResultadoList = []; 
	List<CentroResultadoGrouped> centroResultadoGroupedList = []; 

	CentroResultadoDao(this.db) : super(db);

	Future<List<CentroResultado>> getList() async {
		centroResultadoList = await select(centroResultados).get();
		return centroResultadoList;
	}

	Future<List<CentroResultado>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		centroResultadoList = await (select(centroResultados)..where((t) => expression)).get();
		return centroResultadoList;	 
	}

	Future<List<CentroResultadoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(centroResultados)
			.join([]);

		if (field != null && field != '') { 
			final column = centroResultados.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		centroResultadoGroupedList = await query.map((row) {
			final centroResultado = row.readTableOrNull(centroResultados); 

			return CentroResultadoGrouped(
				centroResultado: centroResultado, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var centroResultadoGrouped in centroResultadoGroupedList) {
		//}		

		return centroResultadoGroupedList;	
	}

	Future<CentroResultado?> getObject(dynamic pk) async {
		return await (select(centroResultados)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CentroResultado?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM centro_resultado WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CentroResultado;		 
	} 

	Future<CentroResultadoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CentroResultadoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.centroResultado = object.centroResultado!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(centroResultados).insert(object.centroResultado!);
			object.centroResultado = object.centroResultado!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CentroResultadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(centroResultados).replace(object.centroResultado!);
		});	 
	} 

	Future<int> deleteObject(CentroResultadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(centroResultados).delete(object.centroResultado!);
		});		
	}

	Future<void> insertChildren(CentroResultadoGrouped object) async {
	}
	
	Future<void> deleteChildren(CentroResultadoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from centro_resultado").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}