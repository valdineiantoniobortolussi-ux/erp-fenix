import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'fiscal_estadual_porte_dao.g.dart';

@DriftAccessor(tables: [
	FiscalEstadualPortes,
])
class FiscalEstadualPorteDao extends DatabaseAccessor<AppDatabase> with _$FiscalEstadualPorteDaoMixin {
	final AppDatabase db;

	List<FiscalEstadualPorte> fiscalEstadualPorteList = []; 
	List<FiscalEstadualPorteGrouped> fiscalEstadualPorteGroupedList = []; 

	FiscalEstadualPorteDao(this.db) : super(db);

	Future<List<FiscalEstadualPorte>> getList() async {
		fiscalEstadualPorteList = await select(fiscalEstadualPortes).get();
		return fiscalEstadualPorteList;
	}

	Future<List<FiscalEstadualPorte>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fiscalEstadualPorteList = await (select(fiscalEstadualPortes)..where((t) => expression)).get();
		return fiscalEstadualPorteList;	 
	}

	Future<List<FiscalEstadualPorteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(fiscalEstadualPortes)
			.join([]);

		if (field != null && field != '') { 
			final column = fiscalEstadualPortes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fiscalEstadualPorteGroupedList = await query.map((row) {
			final fiscalEstadualPorte = row.readTableOrNull(fiscalEstadualPortes); 

			return FiscalEstadualPorteGrouped(
				fiscalEstadualPorte: fiscalEstadualPorte, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var fiscalEstadualPorteGrouped in fiscalEstadualPorteGroupedList) {
		//}		

		return fiscalEstadualPorteGroupedList;	
	}

	Future<FiscalEstadualPorte?> getObject(dynamic pk) async {
		return await (select(fiscalEstadualPortes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FiscalEstadualPorte?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fiscal_estadual_porte WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FiscalEstadualPorte;		 
	} 

	Future<FiscalEstadualPorteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FiscalEstadualPorteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fiscalEstadualPorte = object.fiscalEstadualPorte!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(fiscalEstadualPortes).insert(object.fiscalEstadualPorte!);
			object.fiscalEstadualPorte = object.fiscalEstadualPorte!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FiscalEstadualPorteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(fiscalEstadualPortes).replace(object.fiscalEstadualPorte!);
		});	 
	} 

	Future<int> deleteObject(FiscalEstadualPorteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(fiscalEstadualPortes).delete(object.fiscalEstadualPorte!);
		});		
	}

	Future<void> insertChildren(FiscalEstadualPorteGrouped object) async {
	}
	
	Future<void> deleteChildren(FiscalEstadualPorteGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fiscal_estadual_porte").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}