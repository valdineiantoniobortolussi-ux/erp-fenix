import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/provider/drift/database/database_imports.dart';

@DataClassName("AgendaCompromisso")
class AgendaCompromissos extends Table {
	@override
	String get tableName => 'agenda_compromisso';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idAgendaCategoriaCompromisso => integer().named('id_agenda_categoria_compromisso').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataCompromisso => dateTime().named('data_compromisso').nullable()();
	TextColumn get hora => text().named('hora').withLength(min: 0, max: 8).nullable()();
	IntColumn get duracao => integer().named('duracao').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get onde => text().named('onde').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class AgendaCompromissoGrouped {
	AgendaCompromisso? agendaCompromisso; 
	List<AgendaNotificacaoGrouped>? agendaNotificacaoGroupedList; 
	List<AgendaCompromissoConvidadoGrouped>? agendaCompromissoConvidadoGroupedList; 
	List<ReuniaoSalaEventoGrouped>? reuniaoSalaEventoGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	AgendaCategoriaCompromisso? agendaCategoriaCompromisso; 

  AgendaCompromissoGrouped({
		this.agendaCompromisso, 
		this.agendaNotificacaoGroupedList, 
		this.agendaCompromissoConvidadoGroupedList, 
		this.reuniaoSalaEventoGroupedList, 
		this.viewPessoaColaborador, 
		this.agendaCategoriaCompromisso, 

  });
}
