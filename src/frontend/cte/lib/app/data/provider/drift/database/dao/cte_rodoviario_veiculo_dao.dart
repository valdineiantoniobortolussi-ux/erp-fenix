import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_rodoviario_veiculo_dao.g.dart';

@DriftAccessor(tables: [
	CteRodoviarioVeiculos,
	CteRodoviarios,
])
class CteRodoviarioVeiculoDao extends DatabaseAccessor<AppDatabase> with _$CteRodoviarioVeiculoDaoMixin {
	final AppDatabase db;

	List<CteRodoviarioVeiculo> cteRodoviarioVeiculoList = []; 
	List<CteRodoviarioVeiculoGrouped> cteRodoviarioVeiculoGroupedList = []; 

	CteRodoviarioVeiculoDao(this.db) : super(db);

	Future<List<CteRodoviarioVeiculo>> getList() async {
		cteRodoviarioVeiculoList = await select(cteRodoviarioVeiculos).get();
		return cteRodoviarioVeiculoList;
	}

	Future<List<CteRodoviarioVeiculo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteRodoviarioVeiculoList = await (select(cteRodoviarioVeiculos)..where((t) => expression)).get();
		return cteRodoviarioVeiculoList;	 
	}

	Future<List<CteRodoviarioVeiculoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteRodoviarioVeiculos)
			.join([ 
				leftOuterJoin(cteRodoviarios, cteRodoviarios.id.equalsExp(cteRodoviarioVeiculos.idCteRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = cteRodoviarioVeiculos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteRodoviarioVeiculoGroupedList = await query.map((row) {
			final cteRodoviarioVeiculo = row.readTableOrNull(cteRodoviarioVeiculos); 
			final cteRodoviario = row.readTableOrNull(cteRodoviarios); 

			return CteRodoviarioVeiculoGrouped(
				cteRodoviarioVeiculo: cteRodoviarioVeiculo, 
				cteRodoviario: cteRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteRodoviarioVeiculoGrouped in cteRodoviarioVeiculoGroupedList) {
		//}		

		return cteRodoviarioVeiculoGroupedList;	
	}

	Future<CteRodoviarioVeiculo?> getObject(dynamic pk) async {
		return await (select(cteRodoviarioVeiculos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteRodoviarioVeiculo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_rodoviario_veiculo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteRodoviarioVeiculo;		 
	} 

	Future<CteRodoviarioVeiculoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteRodoviarioVeiculoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteRodoviarioVeiculo = object.cteRodoviarioVeiculo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteRodoviarioVeiculos).insert(object.cteRodoviarioVeiculo!);
			object.cteRodoviarioVeiculo = object.cteRodoviarioVeiculo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteRodoviarioVeiculoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteRodoviarioVeiculos).replace(object.cteRodoviarioVeiculo!);
		});	 
	} 

	Future<int> deleteObject(CteRodoviarioVeiculoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteRodoviarioVeiculos).delete(object.cteRodoviarioVeiculo!);
		});		
	}

	Future<void> insertChildren(CteRodoviarioVeiculoGrouped object) async {
	}
	
	Future<void> deleteChildren(CteRodoviarioVeiculoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_rodoviario_veiculo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}