import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'cst_pis_dao.g.dart';

@DriftAccessor(tables: [
	CstPiss,
])
class CstPisDao extends DatabaseAccessor<AppDatabase> with _$CstPisDaoMixin {
	final AppDatabase db;

	List<CstPis> cstPisList = []; 
	List<CstPisGrouped> cstPisGroupedList = []; 

	CstPisDao(this.db) : super(db);

	Future<List<CstPis>> getList() async {
		cstPisList = await select(cstPiss).get();
		return cstPisList;
	}

	Future<List<CstPis>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cstPisList = await (select(cstPiss)..where((t) => expression)).get();
		return cstPisList;	 
	}

	Future<List<CstPisGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cstPiss)
			.join([]);

		if (field != null && field != '') { 
			final column = cstPiss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cstPisGroupedList = await query.map((row) {
			final cstPis = row.readTableOrNull(cstPiss); 

			return CstPisGrouped(
				cstPis: cstPis, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cstPisGrouped in cstPisGroupedList) {
		//}		

		return cstPisGroupedList;	
	}

	Future<CstPis?> getObject(dynamic pk) async {
		return await (select(cstPiss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CstPis?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cst_pis WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CstPis;		 
	} 

	Future<CstPisGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CstPisGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cstPis = object.cstPis!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cstPiss).insert(object.cstPis!);
			object.cstPis = object.cstPis!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CstPisGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cstPiss).replace(object.cstPis!);
		});	 
	} 

	Future<int> deleteObject(CstPisGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cstPiss).delete(object.cstPis!);
		});		
	}

	Future<void> insertChildren(CstPisGrouped object) async {
	}
	
	Future<void> deleteChildren(CstPisGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cst_pis").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}