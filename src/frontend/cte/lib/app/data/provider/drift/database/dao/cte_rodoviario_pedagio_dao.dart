import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_rodoviario_pedagio_dao.g.dart';

@DriftAccessor(tables: [
	CteRodoviarioPedagios,
	CteRodoviarios,
])
class CteRodoviarioPedagioDao extends DatabaseAccessor<AppDatabase> with _$CteRodoviarioPedagioDaoMixin {
	final AppDatabase db;

	List<CteRodoviarioPedagio> cteRodoviarioPedagioList = []; 
	List<CteRodoviarioPedagioGrouped> cteRodoviarioPedagioGroupedList = []; 

	CteRodoviarioPedagioDao(this.db) : super(db);

	Future<List<CteRodoviarioPedagio>> getList() async {
		cteRodoviarioPedagioList = await select(cteRodoviarioPedagios).get();
		return cteRodoviarioPedagioList;
	}

	Future<List<CteRodoviarioPedagio>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteRodoviarioPedagioList = await (select(cteRodoviarioPedagios)..where((t) => expression)).get();
		return cteRodoviarioPedagioList;	 
	}

	Future<List<CteRodoviarioPedagioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteRodoviarioPedagios)
			.join([ 
				leftOuterJoin(cteRodoviarios, cteRodoviarios.id.equalsExp(cteRodoviarioPedagios.idCteRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = cteRodoviarioPedagios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteRodoviarioPedagioGroupedList = await query.map((row) {
			final cteRodoviarioPedagio = row.readTableOrNull(cteRodoviarioPedagios); 
			final cteRodoviario = row.readTableOrNull(cteRodoviarios); 

			return CteRodoviarioPedagioGrouped(
				cteRodoviarioPedagio: cteRodoviarioPedagio, 
				cteRodoviario: cteRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteRodoviarioPedagioGrouped in cteRodoviarioPedagioGroupedList) {
		//}		

		return cteRodoviarioPedagioGroupedList;	
	}

	Future<CteRodoviarioPedagio?> getObject(dynamic pk) async {
		return await (select(cteRodoviarioPedagios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteRodoviarioPedagio?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_rodoviario_pedagio WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteRodoviarioPedagio;		 
	} 

	Future<CteRodoviarioPedagioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteRodoviarioPedagioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteRodoviarioPedagio = object.cteRodoviarioPedagio!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteRodoviarioPedagios).insert(object.cteRodoviarioPedagio!);
			object.cteRodoviarioPedagio = object.cteRodoviarioPedagio!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteRodoviarioPedagioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteRodoviarioPedagios).replace(object.cteRodoviarioPedagio!);
		});	 
	} 

	Future<int> deleteObject(CteRodoviarioPedagioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteRodoviarioPedagios).delete(object.cteRodoviarioPedagio!);
		});		
	}

	Future<void> insertChildren(CteRodoviarioPedagioGrouped object) async {
	}
	
	Future<void> deleteChildren(CteRodoviarioPedagioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_rodoviario_pedagio").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}