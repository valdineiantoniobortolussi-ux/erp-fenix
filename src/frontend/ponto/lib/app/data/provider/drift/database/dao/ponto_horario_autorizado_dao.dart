import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_horario_autorizado_dao.g.dart';

@DriftAccessor(tables: [
	PontoHorarioAutorizados,
	ViewPessoaColaboradors,
])
class PontoHorarioAutorizadoDao extends DatabaseAccessor<AppDatabase> with _$PontoHorarioAutorizadoDaoMixin {
	final AppDatabase db;

	List<PontoHorarioAutorizado> pontoHorarioAutorizadoList = []; 
	List<PontoHorarioAutorizadoGrouped> pontoHorarioAutorizadoGroupedList = []; 

	PontoHorarioAutorizadoDao(this.db) : super(db);

	Future<List<PontoHorarioAutorizado>> getList() async {
		pontoHorarioAutorizadoList = await select(pontoHorarioAutorizados).get();
		return pontoHorarioAutorizadoList;
	}

	Future<List<PontoHorarioAutorizado>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoHorarioAutorizadoList = await (select(pontoHorarioAutorizados)..where((t) => expression)).get();
		return pontoHorarioAutorizadoList;	 
	}

	Future<List<PontoHorarioAutorizadoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoHorarioAutorizados)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(pontoHorarioAutorizados.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = pontoHorarioAutorizados.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoHorarioAutorizadoGroupedList = await query.map((row) {
			final pontoHorarioAutorizado = row.readTableOrNull(pontoHorarioAutorizados); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return PontoHorarioAutorizadoGrouped(
				pontoHorarioAutorizado: pontoHorarioAutorizado, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var pontoHorarioAutorizadoGrouped in pontoHorarioAutorizadoGroupedList) {
		//}		

		return pontoHorarioAutorizadoGroupedList;	
	}

	Future<PontoHorarioAutorizado?> getObject(dynamic pk) async {
		return await (select(pontoHorarioAutorizados)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoHorarioAutorizado?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_horario_autorizado WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoHorarioAutorizado;		 
	} 

	Future<PontoHorarioAutorizadoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoHorarioAutorizadoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoHorarioAutorizado = object.pontoHorarioAutorizado!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoHorarioAutorizados).insert(object.pontoHorarioAutorizado!);
			object.pontoHorarioAutorizado = object.pontoHorarioAutorizado!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoHorarioAutorizadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoHorarioAutorizados).replace(object.pontoHorarioAutorizado!);
		});	 
	} 

	Future<int> deleteObject(PontoHorarioAutorizadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoHorarioAutorizados).delete(object.pontoHorarioAutorizado!);
		});		
	}

	Future<void> insertChildren(PontoHorarioAutorizadoGrouped object) async {
	}
	
	Future<void> deleteChildren(PontoHorarioAutorizadoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_horario_autorizado").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}