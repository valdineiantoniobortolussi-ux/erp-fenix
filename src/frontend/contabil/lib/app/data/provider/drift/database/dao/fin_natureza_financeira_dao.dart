import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'fin_natureza_financeira_dao.g.dart';

@DriftAccessor(tables: [
	FinNaturezaFinanceiras,
])
class FinNaturezaFinanceiraDao extends DatabaseAccessor<AppDatabase> with _$FinNaturezaFinanceiraDaoMixin {
	final AppDatabase db;

	List<FinNaturezaFinanceira> finNaturezaFinanceiraList = []; 
	List<FinNaturezaFinanceiraGrouped> finNaturezaFinanceiraGroupedList = []; 

	FinNaturezaFinanceiraDao(this.db) : super(db);

	Future<List<FinNaturezaFinanceira>> getList() async {
		finNaturezaFinanceiraList = await select(finNaturezaFinanceiras).get();
		return finNaturezaFinanceiraList;
	}

	Future<List<FinNaturezaFinanceira>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finNaturezaFinanceiraList = await (select(finNaturezaFinanceiras)..where((t) => expression)).get();
		return finNaturezaFinanceiraList;	 
	}

	Future<List<FinNaturezaFinanceiraGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finNaturezaFinanceiras)
			.join([]);

		if (field != null && field != '') { 
			final column = finNaturezaFinanceiras.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finNaturezaFinanceiraGroupedList = await query.map((row) {
			final finNaturezaFinanceira = row.readTableOrNull(finNaturezaFinanceiras); 

			return FinNaturezaFinanceiraGrouped(
				finNaturezaFinanceira: finNaturezaFinanceira, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finNaturezaFinanceiraGrouped in finNaturezaFinanceiraGroupedList) {
		//}		

		return finNaturezaFinanceiraGroupedList;	
	}

	Future<FinNaturezaFinanceira?> getObject(dynamic pk) async {
		return await (select(finNaturezaFinanceiras)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinNaturezaFinanceira?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_natureza_financeira WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinNaturezaFinanceira;		 
	} 

	Future<FinNaturezaFinanceiraGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinNaturezaFinanceiraGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finNaturezaFinanceira = object.finNaturezaFinanceira!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finNaturezaFinanceiras).insert(object.finNaturezaFinanceira!);
			object.finNaturezaFinanceira = object.finNaturezaFinanceira!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinNaturezaFinanceiraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finNaturezaFinanceiras).replace(object.finNaturezaFinanceira!);
		});	 
	} 

	Future<int> deleteObject(FinNaturezaFinanceiraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finNaturezaFinanceiras).delete(object.finNaturezaFinanceira!);
		});		
	}

	Future<void> insertChildren(FinNaturezaFinanceiraGrouped object) async {
	}
	
	Future<void> deleteChildren(FinNaturezaFinanceiraGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_natureza_financeira").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}