import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_horario_dao.g.dart';

@DriftAccessor(tables: [
	PontoHorarios,
])
class PontoHorarioDao extends DatabaseAccessor<AppDatabase> with _$PontoHorarioDaoMixin {
	final AppDatabase db;

	List<PontoHorario> pontoHorarioList = []; 
	List<PontoHorarioGrouped> pontoHorarioGroupedList = []; 

	PontoHorarioDao(this.db) : super(db);

	Future<List<PontoHorario>> getList() async {
		pontoHorarioList = await select(pontoHorarios).get();
		return pontoHorarioList;
	}

	Future<List<PontoHorario>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoHorarioList = await (select(pontoHorarios)..where((t) => expression)).get();
		return pontoHorarioList;	 
	}

	Future<List<PontoHorarioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoHorarios)
			.join([]);

		if (field != null && field != '') { 
			final column = pontoHorarios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoHorarioGroupedList = await query.map((row) {
			final pontoHorario = row.readTableOrNull(pontoHorarios); 

			return PontoHorarioGrouped(
				pontoHorario: pontoHorario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var pontoHorarioGrouped in pontoHorarioGroupedList) {
		//}		

		return pontoHorarioGroupedList;	
	}

	Future<PontoHorario?> getObject(dynamic pk) async {
		return await (select(pontoHorarios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoHorario?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_horario WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoHorario;		 
	} 

	Future<PontoHorarioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoHorarioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoHorario = object.pontoHorario!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoHorarios).insert(object.pontoHorario!);
			object.pontoHorario = object.pontoHorario!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoHorarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoHorarios).replace(object.pontoHorario!);
		});	 
	} 

	Future<int> deleteObject(PontoHorarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoHorarios).delete(object.pontoHorario!);
		});		
	}

	Future<void> insertChildren(PontoHorarioGrouped object) async {
	}
	
	Future<void> deleteChildren(PontoHorarioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_horario").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}