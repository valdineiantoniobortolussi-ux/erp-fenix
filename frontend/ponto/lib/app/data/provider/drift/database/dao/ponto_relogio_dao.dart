import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_relogio_dao.g.dart';

@DriftAccessor(tables: [
	PontoRelogios,
])
class PontoRelogioDao extends DatabaseAccessor<AppDatabase> with _$PontoRelogioDaoMixin {
	final AppDatabase db;

	List<PontoRelogio> pontoRelogioList = []; 
	List<PontoRelogioGrouped> pontoRelogioGroupedList = []; 

	PontoRelogioDao(this.db) : super(db);

	Future<List<PontoRelogio>> getList() async {
		pontoRelogioList = await select(pontoRelogios).get();
		return pontoRelogioList;
	}

	Future<List<PontoRelogio>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoRelogioList = await (select(pontoRelogios)..where((t) => expression)).get();
		return pontoRelogioList;	 
	}

	Future<List<PontoRelogioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoRelogios)
			.join([]);

		if (field != null && field != '') { 
			final column = pontoRelogios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoRelogioGroupedList = await query.map((row) {
			final pontoRelogio = row.readTableOrNull(pontoRelogios); 

			return PontoRelogioGrouped(
				pontoRelogio: pontoRelogio, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var pontoRelogioGrouped in pontoRelogioGroupedList) {
		//}		

		return pontoRelogioGroupedList;	
	}

	Future<PontoRelogio?> getObject(dynamic pk) async {
		return await (select(pontoRelogios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoRelogio?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_relogio WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoRelogio;		 
	} 

	Future<PontoRelogioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoRelogioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoRelogio = object.pontoRelogio!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoRelogios).insert(object.pontoRelogio!);
			object.pontoRelogio = object.pontoRelogio!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoRelogioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoRelogios).replace(object.pontoRelogio!);
		});	 
	} 

	Future<int> deleteObject(PontoRelogioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoRelogios).delete(object.pontoRelogio!);
		});		
	}

	Future<void> insertChildren(PontoRelogioGrouped object) async {
	}
	
	Future<void> deleteChildren(PontoRelogioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_relogio").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}