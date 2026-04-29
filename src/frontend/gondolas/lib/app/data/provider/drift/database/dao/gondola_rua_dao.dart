import 'package:drift/drift.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';
import 'package:gondolas/app/data/provider/drift/database/database_imports.dart';

part 'gondola_rua_dao.g.dart';

@DriftAccessor(tables: [
	GondolaRuas,
])
class GondolaRuaDao extends DatabaseAccessor<AppDatabase> with _$GondolaRuaDaoMixin {
	final AppDatabase db;

	List<GondolaRua> gondolaRuaList = []; 
	List<GondolaRuaGrouped> gondolaRuaGroupedList = []; 

	GondolaRuaDao(this.db) : super(db);

	Future<List<GondolaRua>> getList() async {
		gondolaRuaList = await select(gondolaRuas).get();
		return gondolaRuaList;
	}

	Future<List<GondolaRua>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		gondolaRuaList = await (select(gondolaRuas)..where((t) => expression)).get();
		return gondolaRuaList;	 
	}

	Future<List<GondolaRuaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(gondolaRuas)
			.join([]);

		if (field != null && field != '') { 
			final column = gondolaRuas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		gondolaRuaGroupedList = await query.map((row) {
			final gondolaRua = row.readTableOrNull(gondolaRuas); 

			return GondolaRuaGrouped(
				gondolaRua: gondolaRua, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var gondolaRuaGrouped in gondolaRuaGroupedList) {
		//}		

		return gondolaRuaGroupedList;	
	}

	Future<GondolaRua?> getObject(dynamic pk) async {
		return await (select(gondolaRuas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<GondolaRua?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM gondola_rua WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as GondolaRua;		 
	} 

	Future<GondolaRuaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(GondolaRuaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.gondolaRua = object.gondolaRua!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(gondolaRuas).insert(object.gondolaRua!);
			object.gondolaRua = object.gondolaRua!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(GondolaRuaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(gondolaRuas).replace(object.gondolaRua!);
		});	 
	} 

	Future<int> deleteObject(GondolaRuaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(gondolaRuas).delete(object.gondolaRua!);
		});		
	}

	Future<void> insertChildren(GondolaRuaGrouped object) async {
	}
	
	Future<void> deleteChildren(GondolaRuaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from gondola_rua").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}