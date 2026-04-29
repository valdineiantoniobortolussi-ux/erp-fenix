import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'cst_cofins_dao.g.dart';

@DriftAccessor(tables: [
	CstCofinss,
])
class CstCofinsDao extends DatabaseAccessor<AppDatabase> with _$CstCofinsDaoMixin {
	final AppDatabase db;

	List<CstCofins> cstCofinsList = []; 
	List<CstCofinsGrouped> cstCofinsGroupedList = []; 

	CstCofinsDao(this.db) : super(db);

	Future<List<CstCofins>> getList() async {
		cstCofinsList = await select(cstCofinss).get();
		return cstCofinsList;
	}

	Future<List<CstCofins>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cstCofinsList = await (select(cstCofinss)..where((t) => expression)).get();
		return cstCofinsList;	 
	}

	Future<List<CstCofinsGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cstCofinss)
			.join([]);

		if (field != null && field != '') { 
			final column = cstCofinss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cstCofinsGroupedList = await query.map((row) {
			final cstCofins = row.readTableOrNull(cstCofinss); 

			return CstCofinsGrouped(
				cstCofins: cstCofins, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cstCofinsGrouped in cstCofinsGroupedList) {
		//}		

		return cstCofinsGroupedList;	
	}

	Future<CstCofins?> getObject(dynamic pk) async {
		return await (select(cstCofinss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CstCofins?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cst_cofins WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CstCofins;		 
	} 

	Future<CstCofinsGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CstCofinsGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cstCofins = object.cstCofins!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cstCofinss).insert(object.cstCofins!);
			object.cstCofins = object.cstCofins!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CstCofinsGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cstCofinss).replace(object.cstCofins!);
		});	 
	} 

	Future<int> deleteObject(CstCofinsGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cstCofinss).delete(object.cstCofins!);
		});		
	}

	Future<void> insertChildren(CstCofinsGrouped object) async {
	}
	
	Future<void> deleteChildren(CstCofinsGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cst_cofins").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}