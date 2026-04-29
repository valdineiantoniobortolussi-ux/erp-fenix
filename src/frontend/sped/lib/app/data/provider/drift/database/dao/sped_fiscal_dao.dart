import 'package:drift/drift.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/provider/drift/database/database_imports.dart';

part 'sped_fiscal_dao.g.dart';

@DriftAccessor(tables: [
	SpedFiscals,
])
class SpedFiscalDao extends DatabaseAccessor<AppDatabase> with _$SpedFiscalDaoMixin {
	final AppDatabase db;

	List<SpedFiscal> spedFiscalList = []; 
	List<SpedFiscalGrouped> spedFiscalGroupedList = []; 

	SpedFiscalDao(this.db) : super(db);

	Future<List<SpedFiscal>> getList() async {
		spedFiscalList = await select(spedFiscals).get();
		return spedFiscalList;
	}

	Future<List<SpedFiscal>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		spedFiscalList = await (select(spedFiscals)..where((t) => expression)).get();
		return spedFiscalList;	 
	}

	Future<List<SpedFiscalGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(spedFiscals)
			.join([]);

		if (field != null && field != '') { 
			final column = spedFiscals.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		spedFiscalGroupedList = await query.map((row) {
			final spedFiscal = row.readTableOrNull(spedFiscals); 

			return SpedFiscalGrouped(
				spedFiscal: spedFiscal, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var spedFiscalGrouped in spedFiscalGroupedList) {
		//}		

		return spedFiscalGroupedList;	
	}

	Future<SpedFiscal?> getObject(dynamic pk) async {
		return await (select(spedFiscals)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<SpedFiscal?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM sped_fiscal WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as SpedFiscal;		 
	} 

	Future<SpedFiscalGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(SpedFiscalGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.spedFiscal = object.spedFiscal!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(spedFiscals).insert(object.spedFiscal!);
			object.spedFiscal = object.spedFiscal!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(SpedFiscalGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(spedFiscals).replace(object.spedFiscal!);
		});	 
	} 

	Future<int> deleteObject(SpedFiscalGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(spedFiscals).delete(object.spedFiscal!);
		});		
	}

	Future<void> insertChildren(SpedFiscalGrouped object) async {
	}
	
	Future<void> deleteChildren(SpedFiscalGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from sped_fiscal").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}