import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'fiscal_estadual_regime_dao.g.dart';

@DriftAccessor(tables: [
	FiscalEstadualRegimes,
])
class FiscalEstadualRegimeDao extends DatabaseAccessor<AppDatabase> with _$FiscalEstadualRegimeDaoMixin {
	final AppDatabase db;

	List<FiscalEstadualRegime> fiscalEstadualRegimeList = []; 
	List<FiscalEstadualRegimeGrouped> fiscalEstadualRegimeGroupedList = []; 

	FiscalEstadualRegimeDao(this.db) : super(db);

	Future<List<FiscalEstadualRegime>> getList() async {
		fiscalEstadualRegimeList = await select(fiscalEstadualRegimes).get();
		return fiscalEstadualRegimeList;
	}

	Future<List<FiscalEstadualRegime>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fiscalEstadualRegimeList = await (select(fiscalEstadualRegimes)..where((t) => expression)).get();
		return fiscalEstadualRegimeList;	 
	}

	Future<List<FiscalEstadualRegimeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(fiscalEstadualRegimes)
			.join([]);

		if (field != null && field != '') { 
			final column = fiscalEstadualRegimes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fiscalEstadualRegimeGroupedList = await query.map((row) {
			final fiscalEstadualRegime = row.readTableOrNull(fiscalEstadualRegimes); 

			return FiscalEstadualRegimeGrouped(
				fiscalEstadualRegime: fiscalEstadualRegime, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var fiscalEstadualRegimeGrouped in fiscalEstadualRegimeGroupedList) {
		//}		

		return fiscalEstadualRegimeGroupedList;	
	}

	Future<FiscalEstadualRegime?> getObject(dynamic pk) async {
		return await (select(fiscalEstadualRegimes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FiscalEstadualRegime?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fiscal_estadual_regime WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FiscalEstadualRegime;		 
	} 

	Future<FiscalEstadualRegimeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FiscalEstadualRegimeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fiscalEstadualRegime = object.fiscalEstadualRegime!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(fiscalEstadualRegimes).insert(object.fiscalEstadualRegime!);
			object.fiscalEstadualRegime = object.fiscalEstadualRegime!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FiscalEstadualRegimeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(fiscalEstadualRegimes).replace(object.fiscalEstadualRegime!);
		});	 
	} 

	Future<int> deleteObject(FiscalEstadualRegimeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(fiscalEstadualRegimes).delete(object.fiscalEstadualRegime!);
		});		
	}

	Future<void> insertChildren(FiscalEstadualRegimeGrouped object) async {
	}
	
	Future<void> deleteChildren(FiscalEstadualRegimeGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fiscal_estadual_regime").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}