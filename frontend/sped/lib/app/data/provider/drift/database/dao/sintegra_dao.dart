import 'package:drift/drift.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/provider/drift/database/database_imports.dart';

part 'sintegra_dao.g.dart';

@DriftAccessor(tables: [
	Sintegras,
])
class SintegraDao extends DatabaseAccessor<AppDatabase> with _$SintegraDaoMixin {
	final AppDatabase db;

	List<Sintegra> sintegraList = []; 
	List<SintegraGrouped> sintegraGroupedList = []; 

	SintegraDao(this.db) : super(db);

	Future<List<Sintegra>> getList() async {
		sintegraList = await select(sintegras).get();
		return sintegraList;
	}

	Future<List<Sintegra>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		sintegraList = await (select(sintegras)..where((t) => expression)).get();
		return sintegraList;	 
	}

	Future<List<SintegraGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(sintegras)
			.join([]);

		if (field != null && field != '') { 
			final column = sintegras.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		sintegraGroupedList = await query.map((row) {
			final sintegra = row.readTableOrNull(sintegras); 

			return SintegraGrouped(
				sintegra: sintegra, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var sintegraGrouped in sintegraGroupedList) {
		//}		

		return sintegraGroupedList;	
	}

	Future<Sintegra?> getObject(dynamic pk) async {
		return await (select(sintegras)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Sintegra?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM sintegra WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Sintegra;		 
	} 

	Future<SintegraGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(SintegraGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.sintegra = object.sintegra!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(sintegras).insert(object.sintegra!);
			object.sintegra = object.sintegra!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(SintegraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(sintegras).replace(object.sintegra!);
		});	 
	} 

	Future<int> deleteObject(SintegraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(sintegras).delete(object.sintegra!);
		});		
	}

	Future<void> insertChildren(SintegraGrouped object) async {
	}
	
	Future<void> deleteChildren(SintegraGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from sintegra").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}