import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';

@DataClassName("AgendaCompromissoConvidado")
class AgendaCompromissoConvidados extends Table {
	@override
	String get tableName => 'agenda_compromisso_convidado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idAgendaCompromisso => integer().named('id_agenda_compromisso').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class AgendaCompromissoConvidadoGrouped {
	AgendaCompromissoConvidado? agendaCompromissoConvidado; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  AgendaCompromissoConvidadoGrouped({
		this.agendaCompromissoConvidado, 
		this.viewPessoaColaborador, 

  });
}
