import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';

part 'cnae_dao.g.dart';

@DriftAccessor(tables: [
	Cnaes,
])
class CnaeDao extends DatabaseAccessor<AppDatabase> with _$CnaeDaoMixin {
	final AppDatabase db;

	List<Cnae> cnaeList = []; 
	List<CnaeGrouped> cnaeGroupedList = []; 

	CnaeDao(this.db) : super(db);

	Future<List<Cnae>> getList() async {
		cnaeList = await select(cnaes).get();
		return cnaeList;
	}

	Future<List<Cnae>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cnaeList = await (select(cnaes)..where((t) => expression)).get();
		return cnaeList;	 
	}

	Future<List<CnaeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cnaes)
			.join([]);

		if (field != null && field != '') { 
			final column = cnaes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cnaeGroupedList = await query.map((row) {
			final cnae = row.readTableOrNull(cnaes); 

			return CnaeGrouped(
				cnae: cnae, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cnaeGrouped in cnaeGroupedList) {
		//}		

		return cnaeGroupedList;	
	}

	Future<Cnae?> getObject(dynamic pk) async {
		return await (select(cnaes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Cnae?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cnae WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Cnae;		 
	} 

	Future<CnaeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CnaeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cnae = object.cnae!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cnaes).insert(object.cnae!);
			object.cnae = object.cnae!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CnaeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cnaes).replace(object.cnae!);
		});	 
	} 

	Future<int> deleteObject(CnaeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cnaes).delete(object.cnae!);
		});		
	}

	Future<void> insertChildren(CnaeGrouped object) async {
	}
	
	Future<void> deleteChildren(CnaeGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cnae").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}