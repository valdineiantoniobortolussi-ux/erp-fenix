import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_classificacao_jornada_dao.g.dart';

@DriftAccessor(tables: [
	PontoClassificacaoJornadas,
])
class PontoClassificacaoJornadaDao extends DatabaseAccessor<AppDatabase> with _$PontoClassificacaoJornadaDaoMixin {
	final AppDatabase db;

	List<PontoClassificacaoJornada> pontoClassificacaoJornadaList = []; 
	List<PontoClassificacaoJornadaGrouped> pontoClassificacaoJornadaGroupedList = []; 

	PontoClassificacaoJornadaDao(this.db) : super(db);

	Future<List<PontoClassificacaoJornada>> getList() async {
		pontoClassificacaoJornadaList = await select(pontoClassificacaoJornadas).get();
		return pontoClassificacaoJornadaList;
	}

	Future<List<PontoClassificacaoJornada>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoClassificacaoJornadaList = await (select(pontoClassificacaoJornadas)..where((t) => expression)).get();
		return pontoClassificacaoJornadaList;	 
	}

	Future<List<PontoClassificacaoJornadaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoClassificacaoJornadas)
			.join([]);

		if (field != null && field != '') { 
			final column = pontoClassificacaoJornadas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoClassificacaoJornadaGroupedList = await query.map((row) {
			final pontoClassificacaoJornada = row.readTableOrNull(pontoClassificacaoJornadas); 

			return PontoClassificacaoJornadaGrouped(
				pontoClassificacaoJornada: pontoClassificacaoJornada, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var pontoClassificacaoJornadaGrouped in pontoClassificacaoJornadaGroupedList) {
		//}		

		return pontoClassificacaoJornadaGroupedList;	
	}

	Future<PontoClassificacaoJornada?> getObject(dynamic pk) async {
		return await (select(pontoClassificacaoJornadas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoClassificacaoJornada?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_classificacao_jornada WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoClassificacaoJornada;		 
	} 

	Future<PontoClassificacaoJornadaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoClassificacaoJornadaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoClassificacaoJornada = object.pontoClassificacaoJornada!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoClassificacaoJornadas).insert(object.pontoClassificacaoJornada!);
			object.pontoClassificacaoJornada = object.pontoClassificacaoJornada!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoClassificacaoJornadaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoClassificacaoJornadas).replace(object.pontoClassificacaoJornada!);
		});	 
	} 

	Future<int> deleteObject(PontoClassificacaoJornadaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoClassificacaoJornadas).delete(object.pontoClassificacaoJornada!);
		});		
	}

	Future<void> insertChildren(PontoClassificacaoJornadaGrouped object) async {
	}
	
	Future<void> deleteChildren(PontoClassificacaoJornadaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_classificacao_jornada").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}