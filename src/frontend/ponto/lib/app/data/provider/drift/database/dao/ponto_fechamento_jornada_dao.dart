import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_fechamento_jornada_dao.g.dart';

@DriftAccessor(tables: [
	PontoFechamentoJornadas,
	ViewPessoaColaboradors,
	PontoClassificacaoJornadas,
])
class PontoFechamentoJornadaDao extends DatabaseAccessor<AppDatabase> with _$PontoFechamentoJornadaDaoMixin {
	final AppDatabase db;

	List<PontoFechamentoJornada> pontoFechamentoJornadaList = []; 
	List<PontoFechamentoJornadaGrouped> pontoFechamentoJornadaGroupedList = []; 

	PontoFechamentoJornadaDao(this.db) : super(db);

	Future<List<PontoFechamentoJornada>> getList() async {
		pontoFechamentoJornadaList = await select(pontoFechamentoJornadas).get();
		return pontoFechamentoJornadaList;
	}

	Future<List<PontoFechamentoJornada>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoFechamentoJornadaList = await (select(pontoFechamentoJornadas)..where((t) => expression)).get();
		return pontoFechamentoJornadaList;	 
	}

	Future<List<PontoFechamentoJornadaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoFechamentoJornadas)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(pontoFechamentoJornadas.idColaborador)), 
			]).join([ 
				leftOuterJoin(pontoClassificacaoJornadas, pontoClassificacaoJornadas.id.equalsExp(pontoFechamentoJornadas.idPontoClassificacaoJornada)), 
			]);

		if (field != null && field != '') { 
			final column = pontoFechamentoJornadas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoFechamentoJornadaGroupedList = await query.map((row) {
			final pontoFechamentoJornada = row.readTableOrNull(pontoFechamentoJornadas); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final pontoClassificacaoJornada = row.readTableOrNull(pontoClassificacaoJornadas); 

			return PontoFechamentoJornadaGrouped(
				pontoFechamentoJornada: pontoFechamentoJornada, 
				viewPessoaColaborador: viewPessoaColaborador, 
				pontoClassificacaoJornada: pontoClassificacaoJornada, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var pontoFechamentoJornadaGrouped in pontoFechamentoJornadaGroupedList) {
		//}		

		return pontoFechamentoJornadaGroupedList;	
	}

	Future<PontoFechamentoJornada?> getObject(dynamic pk) async {
		return await (select(pontoFechamentoJornadas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoFechamentoJornada?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_fechamento_jornada WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoFechamentoJornada;		 
	} 

	Future<PontoFechamentoJornadaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoFechamentoJornadaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoFechamentoJornada = object.pontoFechamentoJornada!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoFechamentoJornadas).insert(object.pontoFechamentoJornada!);
			object.pontoFechamentoJornada = object.pontoFechamentoJornada!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoFechamentoJornadaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoFechamentoJornadas).replace(object.pontoFechamentoJornada!);
		});	 
	} 

	Future<int> deleteObject(PontoFechamentoJornadaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoFechamentoJornadas).delete(object.pontoFechamentoJornada!);
		});		
	}

	Future<void> insertChildren(PontoFechamentoJornadaGrouped object) async {
	}
	
	Future<void> deleteChildren(PontoFechamentoJornadaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_fechamento_jornada").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}