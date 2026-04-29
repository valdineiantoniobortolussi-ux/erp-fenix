import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';

@DataClassName("AgendaNotificacao")
class AgendaNotificacaos extends Table {
	@override
	String get tableName => 'agenda_notificacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idAgendaCompromisso => integer().named('id_agenda_compromisso').nullable()();
	DateTimeColumn get dataNotificacao => dateTime().named('data_notificacao').nullable()();
	TextColumn get hora => text().named('hora').withLength(min: 0, max: 8).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class AgendaNotificacaoGrouped {
	AgendaNotificacao? agendaNotificacao; 

  AgendaNotificacaoGrouped({
		this.agendaNotificacao, 

  });
}
