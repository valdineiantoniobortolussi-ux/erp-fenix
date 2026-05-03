import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'fiscal_municipal_regime_dao.g.dart';

@DriftAccessor(tables: [
	FiscalMunicipalRegimes,
])
class FiscalMunicipalRegimeDao extends DatabaseAccessor<AppDatabase> with _$FiscalMunicipalRegimeDaoMixin {
	final AppDatabase db;

	List<FiscalMunicipalRegime> fiscalMunicipalRegimeList = []; 
	List<FiscalMunicipalRegimeGrouped> fiscalMunicipalRegimeGroupedList = []; 

	FiscalMunicipalRegimeDao(this.db) : super(db);

	Future<List<FiscalMunicipalRegime>> getList() async {
		fiscalMunicipalRegimeList = await select(fiscalMunicipalRegimes).get();
		return fiscalMunicipalRegimeList;
	}

	Future<List<FiscalMunicipalRegime>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fiscalMunicipalRegimeList = await (select(fiscalMunicipalRegimes)..where((t) => expression)).get();
		return fiscalMunicipalRegimeList;	 
	}

	Future<List<FiscalMunicipalRegimeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(fiscalMunicipalRegimes)
			.join([]);

		if (field != null && field != '') { 
			final column = fiscalMunicipalRegimes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fiscalMunicipalRegimeGroupedList = await query.map((row) {
			final fiscalMunicipalRegime = row.readTableOrNull(fiscalMunicipalRegimes); 

			return FiscalMunicipalRegimeGrouped(
				fiscalMunicipalRegime: fiscalMunicipalRegime, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var fiscalMunicipalRegimeGrouped in fiscalMunicipalRegimeGroupedList) {
		//}		

		return fiscalMunicipalRegimeGroupedList;	
	}

	Future<FiscalMunicipalRegime?> getObject(dynamic pk) async {
		return await (select(fiscalMunicipalRegimes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FiscalMunicipalRegime?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fiscal_municipal_regime WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FiscalMunicipalRegime;		 
	} 

	Future<FiscalMunicipalRegimeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FiscalMunicipalRegimeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fiscalMunicipalRegime = object.fiscalMunicipalRegime!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(fiscalMunicipalRegimes).insert(object.fiscalMunicipalRegime!);
			object.fiscalMunicipalRegime = object.fiscalMunicipalRegime!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FiscalMunicipalRegimeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(fiscalMunicipalRegimes).replace(object.fiscalMunicipalRegime!);
		});	 
	} 

	Future<int> deleteObject(FiscalMunicipalRegimeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(fiscalMunicipalRegimes).delete(object.fiscalMunicipalRegime!);
		});		
	}

	Future<void> insertChildren(FiscalMunicipalRegimeGrouped object) async {
	}
	
	Future<void> deleteChildren(FiscalMunicipalRegimeGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fiscal_municipal_regime").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}