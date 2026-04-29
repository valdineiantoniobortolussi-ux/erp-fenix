import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'pais_dao.g.dart';

@DriftAccessor(tables: [
	Paiss,
])
class PaisDao extends DatabaseAccessor<AppDatabase> with _$PaisDaoMixin {
	final AppDatabase db;

	List<Pais> paisList = []; 
	List<PaisGrouped> paisGroupedList = []; 

	PaisDao(this.db) : super(db);

	Future<List<Pais>> getList() async {
		paisList = await select(paiss).get();
		return paisList;
	}

	Future<List<Pais>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		paisList = await (select(paiss)..where((t) => expression)).get();
		return paisList;	 
	}

	Future<List<PaisGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(paiss)
			.join([]);

		if (field != null && field != '') { 
			final column = paiss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		paisGroupedList = await query.map((row) {
			final pais = row.readTableOrNull(paiss); 

			return PaisGrouped(
				pais: pais, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var paisGrouped in paisGroupedList) {
		//}		

		return paisGroupedList;	
	}

	Future<Pais?> getObject(dynamic pk) async {
		return await (select(paiss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Pais?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM pais WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Pais;		 
	} 

	Future<PaisGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PaisGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pais = object.pais!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(paiss).insert(object.pais!);
			object.pais = object.pais!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PaisGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(paiss).replace(object.pais!);
		});	 
	} 

	Future<int> deleteObject(PaisGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(paiss).delete(object.pais!);
		});		
	}

	Future<void> insertChildren(PaisGrouped object) async {
	}
	
	Future<void> deleteChildren(PaisGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from pais").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}