import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_banco_horas_dao.g.dart';

@DriftAccessor(tables: [
	PontoBancoHorass,
	PontoBancoHorasUtilizacaos,
	ViewPessoaColaboradors,
])
class PontoBancoHorasDao extends DatabaseAccessor<AppDatabase> with _$PontoBancoHorasDaoMixin {
	final AppDatabase db;

	List<PontoBancoHoras> pontoBancoHorasList = []; 
	List<PontoBancoHorasGrouped> pontoBancoHorasGroupedList = []; 

	PontoBancoHorasDao(this.db) : super(db);

	Future<List<PontoBancoHoras>> getList() async {
		pontoBancoHorasList = await select(pontoBancoHorass).get();
		return pontoBancoHorasList;
	}

	Future<List<PontoBancoHoras>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoBancoHorasList = await (select(pontoBancoHorass)..where((t) => expression)).get();
		return pontoBancoHorasList;	 
	}

	Future<List<PontoBancoHorasGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoBancoHorass)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(pontoBancoHorass.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = pontoBancoHorass.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoBancoHorasGroupedList = await query.map((row) {
			final pontoBancoHoras = row.readTableOrNull(pontoBancoHorass); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return PontoBancoHorasGrouped(
				pontoBancoHoras: pontoBancoHoras, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var pontoBancoHorasGrouped in pontoBancoHorasGroupedList) {
			pontoBancoHorasGrouped.pontoBancoHorasUtilizacaoGroupedList = [];
			final queryPontoBancoHorasUtilizacao = ' id_ponto_banco_horas = ${pontoBancoHorasGrouped.pontoBancoHoras!.id}';
			expression = CustomExpression<bool>(queryPontoBancoHorasUtilizacao);
			final pontoBancoHorasUtilizacaoList = await (select(pontoBancoHorasUtilizacaos)..where((t) => expression)).get();
			for (var pontoBancoHorasUtilizacao in pontoBancoHorasUtilizacaoList) {
				PontoBancoHorasUtilizacaoGrouped pontoBancoHorasUtilizacaoGrouped = PontoBancoHorasUtilizacaoGrouped(
					pontoBancoHorasUtilizacao: pontoBancoHorasUtilizacao,
				);
				pontoBancoHorasGrouped.pontoBancoHorasUtilizacaoGroupedList!.add(pontoBancoHorasUtilizacaoGrouped);
			}

		}		

		return pontoBancoHorasGroupedList;	
	}

	Future<PontoBancoHoras?> getObject(dynamic pk) async {
		return await (select(pontoBancoHorass)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoBancoHoras?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_banco_horas WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoBancoHoras;		 
	} 

	Future<PontoBancoHorasGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoBancoHorasGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoBancoHoras = object.pontoBancoHoras!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoBancoHorass).insert(object.pontoBancoHoras!);
			object.pontoBancoHoras = object.pontoBancoHoras!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoBancoHorasGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoBancoHorass).replace(object.pontoBancoHoras!);
		});	 
	} 

	Future<int> deleteObject(PontoBancoHorasGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoBancoHorass).delete(object.pontoBancoHoras!);
		});		
	}

	Future<void> insertChildren(PontoBancoHorasGrouped object) async {
		for (var pontoBancoHorasUtilizacaoGrouped in object.pontoBancoHorasUtilizacaoGroupedList!) {
			pontoBancoHorasUtilizacaoGrouped.pontoBancoHorasUtilizacao = pontoBancoHorasUtilizacaoGrouped.pontoBancoHorasUtilizacao?.copyWith(
				id: const Value(null),
				idPontoBancoHoras: Value(object.pontoBancoHoras!.id),
			);
			await into(pontoBancoHorasUtilizacaos).insert(pontoBancoHorasUtilizacaoGrouped.pontoBancoHorasUtilizacao!);
		}
	}
	
	Future<void> deleteChildren(PontoBancoHorasGrouped object) async {
		await (delete(pontoBancoHorasUtilizacaos)..where((t) => t.idPontoBancoHoras.equals(object.pontoBancoHoras!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_banco_horas").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}