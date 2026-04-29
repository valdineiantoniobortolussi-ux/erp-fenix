import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'operadora_plano_saude_dao.g.dart';

@DriftAccessor(tables: [
	OperadoraPlanoSaudes,
])
class OperadoraPlanoSaudeDao extends DatabaseAccessor<AppDatabase> with _$OperadoraPlanoSaudeDaoMixin {
	final AppDatabase db;

	List<OperadoraPlanoSaude> operadoraPlanoSaudeList = []; 
	List<OperadoraPlanoSaudeGrouped> operadoraPlanoSaudeGroupedList = []; 

	OperadoraPlanoSaudeDao(this.db) : super(db);

	Future<List<OperadoraPlanoSaude>> getList() async {
		operadoraPlanoSaudeList = await select(operadoraPlanoSaudes).get();
		return operadoraPlanoSaudeList;
	}

	Future<List<OperadoraPlanoSaude>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		operadoraPlanoSaudeList = await (select(operadoraPlanoSaudes)..where((t) => expression)).get();
		return operadoraPlanoSaudeList;	 
	}

	Future<List<OperadoraPlanoSaudeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(operadoraPlanoSaudes)
			.join([]);

		if (field != null && field != '') { 
			final column = operadoraPlanoSaudes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		operadoraPlanoSaudeGroupedList = await query.map((row) {
			final operadoraPlanoSaude = row.readTableOrNull(operadoraPlanoSaudes); 

			return OperadoraPlanoSaudeGrouped(
				operadoraPlanoSaude: operadoraPlanoSaude, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var operadoraPlanoSaudeGrouped in operadoraPlanoSaudeGroupedList) {
		//}		

		return operadoraPlanoSaudeGroupedList;	
	}

	Future<OperadoraPlanoSaude?> getObject(dynamic pk) async {
		return await (select(operadoraPlanoSaudes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<OperadoraPlanoSaude?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM operadora_plano_saude WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as OperadoraPlanoSaude;		 
	} 

	Future<OperadoraPlanoSaudeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(OperadoraPlanoSaudeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.operadoraPlanoSaude = object.operadoraPlanoSaude!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(operadoraPlanoSaudes).insert(object.operadoraPlanoSaude!);
			object.operadoraPlanoSaude = object.operadoraPlanoSaude!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(OperadoraPlanoSaudeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(operadoraPlanoSaudes).replace(object.operadoraPlanoSaude!);
		});	 
	} 

	Future<int> deleteObject(OperadoraPlanoSaudeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(operadoraPlanoSaudes).delete(object.operadoraPlanoSaude!);
		});		
	}

	Future<void> insertChildren(OperadoraPlanoSaudeGrouped object) async {
	}
	
	Future<void> deleteChildren(OperadoraPlanoSaudeGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from operadora_plano_saude").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}