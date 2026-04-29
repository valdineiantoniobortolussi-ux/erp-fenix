import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'fiscal_apuracao_icms_dao.g.dart';

@DriftAccessor(tables: [
	FiscalApuracaoIcmss,
])
class FiscalApuracaoIcmsDao extends DatabaseAccessor<AppDatabase> with _$FiscalApuracaoIcmsDaoMixin {
	final AppDatabase db;

	List<FiscalApuracaoIcms> fiscalApuracaoIcmsList = []; 
	List<FiscalApuracaoIcmsGrouped> fiscalApuracaoIcmsGroupedList = []; 

	FiscalApuracaoIcmsDao(this.db) : super(db);

	Future<List<FiscalApuracaoIcms>> getList() async {
		fiscalApuracaoIcmsList = await select(fiscalApuracaoIcmss).get();
		return fiscalApuracaoIcmsList;
	}

	Future<List<FiscalApuracaoIcms>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fiscalApuracaoIcmsList = await (select(fiscalApuracaoIcmss)..where((t) => expression)).get();
		return fiscalApuracaoIcmsList;	 
	}

	Future<List<FiscalApuracaoIcmsGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(fiscalApuracaoIcmss)
			.join([]);

		if (field != null && field != '') { 
			final column = fiscalApuracaoIcmss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fiscalApuracaoIcmsGroupedList = await query.map((row) {
			final fiscalApuracaoIcms = row.readTableOrNull(fiscalApuracaoIcmss); 

			return FiscalApuracaoIcmsGrouped(
				fiscalApuracaoIcms: fiscalApuracaoIcms, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var fiscalApuracaoIcmsGrouped in fiscalApuracaoIcmsGroupedList) {
		//}		

		return fiscalApuracaoIcmsGroupedList;	
	}

	Future<FiscalApuracaoIcms?> getObject(dynamic pk) async {
		return await (select(fiscalApuracaoIcmss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FiscalApuracaoIcms?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fiscal_apuracao_icms WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FiscalApuracaoIcms;		 
	} 

	Future<FiscalApuracaoIcmsGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FiscalApuracaoIcmsGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fiscalApuracaoIcms = object.fiscalApuracaoIcms!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(fiscalApuracaoIcmss).insert(object.fiscalApuracaoIcms!);
			object.fiscalApuracaoIcms = object.fiscalApuracaoIcms!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FiscalApuracaoIcmsGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(fiscalApuracaoIcmss).replace(object.fiscalApuracaoIcms!);
		});	 
	} 

	Future<int> deleteObject(FiscalApuracaoIcmsGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(fiscalApuracaoIcmss).delete(object.fiscalApuracaoIcms!);
		});		
	}

	Future<void> insertChildren(FiscalApuracaoIcmsGrouped object) async {
	}
	
	Future<void> deleteChildren(FiscalApuracaoIcmsGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fiscal_apuracao_icms").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}