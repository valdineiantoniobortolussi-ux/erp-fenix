import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/provider/drift/database/database_imports.dart';

part 'reuniao_sala_dao.g.dart';

@DriftAccessor(tables: [
	ReuniaoSalas,
])
class ReuniaoSalaDao extends DatabaseAccessor<AppDatabase> with _$ReuniaoSalaDaoMixin {
	final AppDatabase db;

	List<ReuniaoSala> reuniaoSalaList = []; 
	List<ReuniaoSalaGrouped> reuniaoSalaGroupedList = []; 

	ReuniaoSalaDao(this.db) : super(db);

	Future<List<ReuniaoSala>> getList() async {
		reuniaoSalaList = await select(reuniaoSalas).get();
		return reuniaoSalaList;
	}

	Future<List<ReuniaoSala>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		reuniaoSalaList = await (select(reuniaoSalas)..where((t) => expression)).get();
		return reuniaoSalaList;	 
	}

	Future<List<ReuniaoSalaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(reuniaoSalas)
			.join([]);

		if (field != null && field != '') { 
			final column = reuniaoSalas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		reuniaoSalaGroupedList = await query.map((row) {
			final reuniaoSala = row.readTableOrNull(reuniaoSalas); 

			return ReuniaoSalaGrouped(
				reuniaoSala: reuniaoSala, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var reuniaoSalaGrouped in reuniaoSalaGroupedList) {
		//}		

		return reuniaoSalaGroupedList;	
	}

	Future<ReuniaoSala?> getObject(dynamic pk) async {
		return await (select(reuniaoSalas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ReuniaoSala?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM reuniao_sala WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ReuniaoSala;		 
	} 

	Future<ReuniaoSalaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ReuniaoSalaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.reuniaoSala = object.reuniaoSala!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(reuniaoSalas).insert(object.reuniaoSala!);
			object.reuniaoSala = object.reuniaoSala!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ReuniaoSalaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(reuniaoSalas).replace(object.reuniaoSala!);
		});	 
	} 

	Future<int> deleteObject(ReuniaoSalaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(reuniaoSalas).delete(object.reuniaoSala!);
		});		
	}

	Future<void> insertChildren(ReuniaoSalaGrouped object) async {
	}
	
	Future<void> deleteChildren(ReuniaoSalaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from reuniao_sala").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}