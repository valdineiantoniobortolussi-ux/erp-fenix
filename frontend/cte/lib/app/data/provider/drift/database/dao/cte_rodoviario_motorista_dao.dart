import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_rodoviario_motorista_dao.g.dart';

@DriftAccessor(tables: [
	CteRodoviarioMotoristas,
	CteRodoviarios,
])
class CteRodoviarioMotoristaDao extends DatabaseAccessor<AppDatabase> with _$CteRodoviarioMotoristaDaoMixin {
	final AppDatabase db;

	List<CteRodoviarioMotorista> cteRodoviarioMotoristaList = []; 
	List<CteRodoviarioMotoristaGrouped> cteRodoviarioMotoristaGroupedList = []; 

	CteRodoviarioMotoristaDao(this.db) : super(db);

	Future<List<CteRodoviarioMotorista>> getList() async {
		cteRodoviarioMotoristaList = await select(cteRodoviarioMotoristas).get();
		return cteRodoviarioMotoristaList;
	}

	Future<List<CteRodoviarioMotorista>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteRodoviarioMotoristaList = await (select(cteRodoviarioMotoristas)..where((t) => expression)).get();
		return cteRodoviarioMotoristaList;	 
	}

	Future<List<CteRodoviarioMotoristaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteRodoviarioMotoristas)
			.join([ 
				leftOuterJoin(cteRodoviarios, cteRodoviarios.id.equalsExp(cteRodoviarioMotoristas.idCteRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = cteRodoviarioMotoristas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteRodoviarioMotoristaGroupedList = await query.map((row) {
			final cteRodoviarioMotorista = row.readTableOrNull(cteRodoviarioMotoristas); 
			final cteRodoviario = row.readTableOrNull(cteRodoviarios); 

			return CteRodoviarioMotoristaGrouped(
				cteRodoviarioMotorista: cteRodoviarioMotorista, 
				cteRodoviario: cteRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteRodoviarioMotoristaGrouped in cteRodoviarioMotoristaGroupedList) {
		//}		

		return cteRodoviarioMotoristaGroupedList;	
	}

	Future<CteRodoviarioMotorista?> getObject(dynamic pk) async {
		return await (select(cteRodoviarioMotoristas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteRodoviarioMotorista?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_rodoviario_motorista WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteRodoviarioMotorista;		 
	} 

	Future<CteRodoviarioMotoristaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteRodoviarioMotoristaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteRodoviarioMotorista = object.cteRodoviarioMotorista!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteRodoviarioMotoristas).insert(object.cteRodoviarioMotorista!);
			object.cteRodoviarioMotorista = object.cteRodoviarioMotorista!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteRodoviarioMotoristaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteRodoviarioMotoristas).replace(object.cteRodoviarioMotorista!);
		});	 
	} 

	Future<int> deleteObject(CteRodoviarioMotoristaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteRodoviarioMotoristas).delete(object.cteRodoviarioMotorista!);
		});		
	}

	Future<void> insertChildren(CteRodoviarioMotoristaGrouped object) async {
	}
	
	Future<void> deleteChildren(CteRodoviarioMotoristaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_rodoviario_motorista").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}