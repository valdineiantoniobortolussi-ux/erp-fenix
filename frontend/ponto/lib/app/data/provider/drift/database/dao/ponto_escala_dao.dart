import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_escala_dao.g.dart';

@DriftAccessor(tables: [
	PontoEscalas,
	PontoTurmas,
])
class PontoEscalaDao extends DatabaseAccessor<AppDatabase> with _$PontoEscalaDaoMixin {
	final AppDatabase db;

	List<PontoEscala> pontoEscalaList = []; 
	List<PontoEscalaGrouped> pontoEscalaGroupedList = []; 

	PontoEscalaDao(this.db) : super(db);

	Future<List<PontoEscala>> getList() async {
		pontoEscalaList = await select(pontoEscalas).get();
		return pontoEscalaList;
	}

	Future<List<PontoEscala>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoEscalaList = await (select(pontoEscalas)..where((t) => expression)).get();
		return pontoEscalaList;	 
	}

	Future<List<PontoEscalaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoEscalas)
			.join([]);

		if (field != null && field != '') { 
			final column = pontoEscalas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoEscalaGroupedList = await query.map((row) {
			final pontoEscala = row.readTableOrNull(pontoEscalas); 

			return PontoEscalaGrouped(
				pontoEscala: pontoEscala, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var pontoEscalaGrouped in pontoEscalaGroupedList) {
			pontoEscalaGrouped.pontoTurmaGroupedList = [];
			final queryPontoTurma = ' id_ponto_escala = ${pontoEscalaGrouped.pontoEscala!.id}';
			expression = CustomExpression<bool>(queryPontoTurma);
			final pontoTurmaList = await (select(pontoTurmas)..where((t) => expression)).get();
			for (var pontoTurma in pontoTurmaList) {
				PontoTurmaGrouped pontoTurmaGrouped = PontoTurmaGrouped(
					pontoTurma: pontoTurma,
				);
				pontoEscalaGrouped.pontoTurmaGroupedList!.add(pontoTurmaGrouped);
			}

		}		

		return pontoEscalaGroupedList;	
	}

	Future<PontoEscala?> getObject(dynamic pk) async {
		return await (select(pontoEscalas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoEscala?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_escala WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoEscala;		 
	} 

	Future<PontoEscalaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoEscalaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoEscala = object.pontoEscala!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoEscalas).insert(object.pontoEscala!);
			object.pontoEscala = object.pontoEscala!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoEscalaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoEscalas).replace(object.pontoEscala!);
		});	 
	} 

	Future<int> deleteObject(PontoEscalaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoEscalas).delete(object.pontoEscala!);
		});		
	}

	Future<void> insertChildren(PontoEscalaGrouped object) async {
		for (var pontoTurmaGrouped in object.pontoTurmaGroupedList!) {
			pontoTurmaGrouped.pontoTurma = pontoTurmaGrouped.pontoTurma?.copyWith(
				id: const Value(null),
				idPontoEscala: Value(object.pontoEscala!.id),
			);
			await into(pontoTurmas).insert(pontoTurmaGrouped.pontoTurma!);
		}
	}
	
	Future<void> deleteChildren(PontoEscalaGrouped object) async {
		await (delete(pontoTurmas)..where((t) => t.idPontoEscala.equals(object.pontoEscala!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_escala").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}