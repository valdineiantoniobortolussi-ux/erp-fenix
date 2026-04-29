import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';

@DataClassName("ReuniaoSalaEvento")
class ReuniaoSalaEventos extends Table {
	@override
	String get tableName => 'reuniao_sala_evento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idAgendaCompromisso => integer().named('id_agenda_compromisso').nullable()();
	IntColumn get idReuniaoSala => integer().named('id_reuniao_sala').nullable()();
	DateTimeColumn get dataReserva => dateTime().named('data_reserva').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ReuniaoSalaEventoGrouped {
	ReuniaoSalaEvento? reuniaoSalaEvento; 
	ReuniaoSala? reuniaoSala; 

  ReuniaoSalaEventoGrouped({
		this.reuniaoSalaEvento, 
		this.reuniaoSala, 

  });
}
