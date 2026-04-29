import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'cst_ipi_dao.g.dart';

@DriftAccessor(tables: [
	CstIpis,
])
class CstIpiDao extends DatabaseAccessor<AppDatabase> with _$CstIpiDaoMixin {
	final AppDatabase db;

	List<CstIpi> cstIpiList = []; 
	List<CstIpiGrouped> cstIpiGroupedList = []; 

	CstIpiDao(this.db) : super(db);

	Future<List<CstIpi>> getList() async {
		cstIpiList = await select(cstIpis).get();
		return cstIpiList;
	}

	Future<List<CstIpi>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cstIpiList = await (select(cstIpis)..where((t) => expression)).get();
		return cstIpiList;	 
	}

	Future<List<CstIpiGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cstIpis)
			.join([]);

		if (field != null && field != '') { 
			final column = cstIpis.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cstIpiGroupedList = await query.map((row) {
			final cstIpi = row.readTableOrNull(cstIpis); 

			return CstIpiGrouped(
				cstIpi: cstIpi, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cstIpiGrouped in cstIpiGroupedList) {
		//}		

		return cstIpiGroupedList;	
	}

	Future<CstIpi?> getObject(dynamic pk) async {
		return await (select(cstIpis)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CstIpi?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cst_ipi WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CstIpi;		 
	} 

	Future<CstIpiGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CstIpiGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cstIpi = object.cstIpi!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cstIpis).insert(object.cstIpi!);
			object.cstIpi = object.cstIpi!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CstIpiGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cstIpis).replace(object.cstIpi!);
		});	 
	} 

	Future<int> deleteObject(CstIpiGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cstIpis).delete(object.cstIpi!);
		});		
	}

	Future<void> insertChildren(CstIpiGrouped object) async {
	}
	
	Future<void> deleteChildren(CstIpiGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cst_ipi").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}