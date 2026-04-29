import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'plano_conta_dao.g.dart';

@DriftAccessor(tables: [
	PlanoContas,
])
class PlanoContaDao extends DatabaseAccessor<AppDatabase> with _$PlanoContaDaoMixin {
	final AppDatabase db;

	List<PlanoConta> planoContaList = []; 
	List<PlanoContaGrouped> planoContaGroupedList = []; 

	PlanoContaDao(this.db) : super(db);

	Future<List<PlanoConta>> getList() async {
		planoContaList = await select(planoContas).get();
		return planoContaList;
	}

	Future<List<PlanoConta>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		planoContaList = await (select(planoContas)..where((t) => expression)).get();
		return planoContaList;	 
	}

	Future<List<PlanoContaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(planoContas)
			.join([]);

		if (field != null && field != '') { 
			final column = planoContas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		planoContaGroupedList = await query.map((row) {
			final planoConta = row.readTableOrNull(planoContas); 

			return PlanoContaGrouped(
				planoConta: planoConta, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var planoContaGrouped in planoContaGroupedList) {
		//}		

		return planoContaGroupedList;	
	}

	Future<PlanoConta?> getObject(dynamic pk) async {
		return await (select(planoContas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PlanoConta?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM plano_conta WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PlanoConta;		 
	} 

	Future<PlanoContaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PlanoContaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.planoConta = object.planoConta!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(planoContas).insert(object.planoConta!);
			object.planoConta = object.planoConta!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PlanoContaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(planoContas).replace(object.planoConta!);
		});	 
	} 

	Future<int> deleteObject(PlanoContaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(planoContas).delete(object.planoConta!);
		});		
	}

	Future<void> insertChildren(PlanoContaGrouped object) async {
	}
	
	Future<void> deleteChildren(PlanoContaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from plano_conta").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}