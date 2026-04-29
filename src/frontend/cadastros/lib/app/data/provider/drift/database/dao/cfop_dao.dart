import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'cfop_dao.g.dart';

@DriftAccessor(tables: [
	Cfops,
])
class CfopDao extends DatabaseAccessor<AppDatabase> with _$CfopDaoMixin {
	final AppDatabase db;

	List<Cfop> cfopList = []; 
	List<CfopGrouped> cfopGroupedList = []; 

	CfopDao(this.db) : super(db);

	Future<List<Cfop>> getList() async {
		cfopList = await select(cfops).get();
		return cfopList;
	}

	Future<List<Cfop>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cfopList = await (select(cfops)..where((t) => expression)).get();
		return cfopList;	 
	}

	Future<List<CfopGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cfops)
			.join([]);

		if (field != null && field != '') { 
			final column = cfops.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cfopGroupedList = await query.map((row) {
			final cfop = row.readTableOrNull(cfops); 

			return CfopGrouped(
				cfop: cfop, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cfopGrouped in cfopGroupedList) {
		//}		

		return cfopGroupedList;	
	}

	Future<Cfop?> getObject(dynamic pk) async {
		return await (select(cfops)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Cfop?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cfop WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Cfop;		 
	} 

	Future<CfopGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CfopGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cfop = object.cfop!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cfops).insert(object.cfop!);
			object.cfop = object.cfop!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CfopGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cfops).replace(object.cfop!);
		});	 
	} 

	Future<int> deleteObject(CfopGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cfops).delete(object.cfop!);
		});		
	}

	Future<void> insertChildren(CfopGrouped object) async {
	}
	
	Future<void> deleteChildren(CfopGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cfop").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}