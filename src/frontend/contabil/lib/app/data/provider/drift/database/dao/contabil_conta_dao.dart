import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_conta_dao.g.dart';

@DriftAccessor(tables: [
	ContabilContas,
	PlanoContas,
	PlanoContaRefSpeds,
])
class ContabilContaDao extends DatabaseAccessor<AppDatabase> with _$ContabilContaDaoMixin {
	final AppDatabase db;

	List<ContabilConta> contabilContaList = []; 
	List<ContabilContaGrouped> contabilContaGroupedList = []; 

	ContabilContaDao(this.db) : super(db);

	Future<List<ContabilConta>> getList() async {
		contabilContaList = await select(contabilContas).get();
		return contabilContaList;
	}

	Future<List<ContabilConta>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilContaList = await (select(contabilContas)..where((t) => expression)).get();
		return contabilContaList;	 
	}

	Future<List<ContabilContaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilContas)
			.join([ 
				leftOuterJoin(planoContas, planoContas.id.equalsExp(contabilContas.idPlanoConta)), 
			]).join([ 
				leftOuterJoin(planoContaRefSpeds, planoContaRefSpeds.id.equalsExp(contabilContas.idPlanoContaRefSped)), 
			]);

		if (field != null && field != '') { 
			final column = contabilContas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilContaGroupedList = await query.map((row) {
			final contabilConta = row.readTableOrNull(contabilContas); 
			final planoConta = row.readTableOrNull(planoContas); 
			final planoContaRefSped = row.readTableOrNull(planoContaRefSpeds); 

			return ContabilContaGrouped(
				contabilConta: contabilConta, 
				planoConta: planoConta, 
				planoContaRefSped: planoContaRefSped, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contabilContaGrouped in contabilContaGroupedList) {
		//}		

		return contabilContaGroupedList;	
	}

	Future<ContabilConta?> getObject(dynamic pk) async {
		return await (select(contabilContas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilConta?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_conta WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilConta;		 
	} 

	Future<ContabilContaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilContaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilConta = object.contabilConta!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilContas).insert(object.contabilConta!);
			object.contabilConta = object.contabilConta!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilContaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilContas).replace(object.contabilConta!);
		});	 
	} 

	Future<int> deleteObject(ContabilContaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilContas).delete(object.contabilConta!);
		});		
	}

	Future<void> insertChildren(ContabilContaGrouped object) async {
	}
	
	Future<void> deleteChildren(ContabilContaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_conta").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}