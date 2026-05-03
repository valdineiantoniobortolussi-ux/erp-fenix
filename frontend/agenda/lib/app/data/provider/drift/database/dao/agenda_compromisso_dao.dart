import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/provider/drift/database/database_imports.dart';

part 'agenda_compromisso_dao.g.dart';

@DriftAccessor(tables: [
	AgendaCompromissos,
	AgendaNotificacaos,
	AgendaCompromissoConvidados,
	ViewPessoaColaboradors,
	ReuniaoSalaEventos,
	ReuniaoSalas,
	ViewPessoaColaboradors,
	AgendaCategoriaCompromissos,
])
class AgendaCompromissoDao extends DatabaseAccessor<AppDatabase> with _$AgendaCompromissoDaoMixin {
	final AppDatabase db;

	List<AgendaCompromisso> agendaCompromissoList = []; 
	List<AgendaCompromissoGrouped> agendaCompromissoGroupedList = []; 

	AgendaCompromissoDao(this.db) : super(db);

	Future<List<AgendaCompromisso>> getList() async {
		agendaCompromissoList = await select(agendaCompromissos).get();
		return agendaCompromissoList;
	}

	Future<List<AgendaCompromisso>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		agendaCompromissoList = await (select(agendaCompromissos)..where((t) => expression)).get();
		return agendaCompromissoList;	 
	}

	Future<List<AgendaCompromissoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(agendaCompromissos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(agendaCompromissos.idColaborador)), 
			]).join([ 
				leftOuterJoin(agendaCategoriaCompromissos, agendaCategoriaCompromissos.id.equalsExp(agendaCompromissos.idAgendaCategoriaCompromisso)), 
			]);

		if (field != null && field != '') { 
			final column = agendaCompromissos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		agendaCompromissoGroupedList = await query.map((row) {
			final agendaCompromisso = row.readTableOrNull(agendaCompromissos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final agendaCategoriaCompromisso = row.readTableOrNull(agendaCategoriaCompromissos); 

			return AgendaCompromissoGrouped(
				agendaCompromisso: agendaCompromisso, 
				viewPessoaColaborador: viewPessoaColaborador, 
				agendaCategoriaCompromisso: agendaCategoriaCompromisso, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var agendaCompromissoGrouped in agendaCompromissoGroupedList) {
			agendaCompromissoGrouped.agendaNotificacaoGroupedList = [];
			final queryAgendaNotificacao = ' id_agenda_compromisso = ${agendaCompromissoGrouped.agendaCompromisso!.id}';
			expression = CustomExpression<bool>(queryAgendaNotificacao);
			final agendaNotificacaoList = await (select(agendaNotificacaos)..where((t) => expression)).get();
			for (var agendaNotificacao in agendaNotificacaoList) {
				AgendaNotificacaoGrouped agendaNotificacaoGrouped = AgendaNotificacaoGrouped(
					agendaNotificacao: agendaNotificacao,
				);
				agendaCompromissoGrouped.agendaNotificacaoGroupedList!.add(agendaNotificacaoGrouped);
			}

			agendaCompromissoGrouped.agendaCompromissoConvidadoGroupedList = [];
			final queryAgendaCompromissoConvidado = ' id_agenda_compromisso = ${agendaCompromissoGrouped.agendaCompromisso!.id}';
			expression = CustomExpression<bool>(queryAgendaCompromissoConvidado);
			final agendaCompromissoConvidadoList = await (select(agendaCompromissoConvidados)..where((t) => expression)).get();
			for (var agendaCompromissoConvidado in agendaCompromissoConvidadoList) {
				AgendaCompromissoConvidadoGrouped agendaCompromissoConvidadoGrouped = AgendaCompromissoConvidadoGrouped(
					agendaCompromissoConvidado: agendaCompromissoConvidado,
					viewPessoaColaborador: await (select(viewPessoaColaboradors)..where((t) => t.id.equals(agendaCompromissoConvidado.idColaborador!))).getSingleOrNull(),
				);
				agendaCompromissoGrouped.agendaCompromissoConvidadoGroupedList!.add(agendaCompromissoConvidadoGrouped);
			}

			agendaCompromissoGrouped.reuniaoSalaEventoGroupedList = [];
			final queryReuniaoSalaEvento = ' id_agenda_compromisso = ${agendaCompromissoGrouped.agendaCompromisso!.id}';
			expression = CustomExpression<bool>(queryReuniaoSalaEvento);
			final reuniaoSalaEventoList = await (select(reuniaoSalaEventos)..where((t) => expression)).get();
			for (var reuniaoSalaEvento in reuniaoSalaEventoList) {
				ReuniaoSalaEventoGrouped reuniaoSalaEventoGrouped = ReuniaoSalaEventoGrouped(
					reuniaoSalaEvento: reuniaoSalaEvento,
					reuniaoSala: await (select(reuniaoSalas)..where((t) => t.id.equals(reuniaoSalaEvento.idReuniaoSala!))).getSingleOrNull(),
				);
				agendaCompromissoGrouped.reuniaoSalaEventoGroupedList!.add(reuniaoSalaEventoGrouped);
			}

		}		

		return agendaCompromissoGroupedList;	
	}

	Future<AgendaCompromisso?> getObject(dynamic pk) async {
		return await (select(agendaCompromissos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<AgendaCompromisso?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM agenda_compromisso WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as AgendaCompromisso;		 
	} 

	Future<AgendaCompromissoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(AgendaCompromissoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.agendaCompromisso = object.agendaCompromisso!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(agendaCompromissos).insert(object.agendaCompromisso!);
			object.agendaCompromisso = object.agendaCompromisso!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(AgendaCompromissoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(agendaCompromissos).replace(object.agendaCompromisso!);
		});	 
	} 

	Future<int> deleteObject(AgendaCompromissoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(agendaCompromissos).delete(object.agendaCompromisso!);
		});		
	}

	Future<void> insertChildren(AgendaCompromissoGrouped object) async {
		for (var agendaNotificacaoGrouped in object.agendaNotificacaoGroupedList!) {
			agendaNotificacaoGrouped.agendaNotificacao = agendaNotificacaoGrouped.agendaNotificacao?.copyWith(
				id: const Value(null),
				idAgendaCompromisso: Value(object.agendaCompromisso!.id),
			);
			await into(agendaNotificacaos).insert(agendaNotificacaoGrouped.agendaNotificacao!);
		}
		for (var agendaCompromissoConvidadoGrouped in object.agendaCompromissoConvidadoGroupedList!) {
			agendaCompromissoConvidadoGrouped.agendaCompromissoConvidado = agendaCompromissoConvidadoGrouped.agendaCompromissoConvidado?.copyWith(
				id: const Value(null),
				idAgendaCompromisso: Value(object.agendaCompromisso!.id),
			);
			await into(agendaCompromissoConvidados).insert(agendaCompromissoConvidadoGrouped.agendaCompromissoConvidado!);
		}
		for (var reuniaoSalaEventoGrouped in object.reuniaoSalaEventoGroupedList!) {
			reuniaoSalaEventoGrouped.reuniaoSalaEvento = reuniaoSalaEventoGrouped.reuniaoSalaEvento?.copyWith(
				id: const Value(null),
				idAgendaCompromisso: Value(object.agendaCompromisso!.id),
			);
			await into(reuniaoSalaEventos).insert(reuniaoSalaEventoGrouped.reuniaoSalaEvento!);
		}
	}
	
	Future<void> deleteChildren(AgendaCompromissoGrouped object) async {
		await (delete(agendaNotificacaos)..where((t) => t.idAgendaCompromisso.equals(object.agendaCompromisso!.id!))).go();
		await (delete(agendaCompromissoConvidados)..where((t) => t.idAgendaCompromisso.equals(object.agendaCompromisso!.id!))).go();
		await (delete(reuniaoSalaEventos)..where((t) => t.idAgendaCompromisso.equals(object.agendaCompromisso!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from agenda_compromisso").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}