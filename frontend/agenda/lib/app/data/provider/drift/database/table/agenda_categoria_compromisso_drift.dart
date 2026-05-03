import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';

@DataClassName("AgendaCategoriaCompromisso")
class AgendaCategoriaCompromissos extends Table {
	@override
	String get tableName => 'agenda_categoria_compromisso';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get cor => text().named('cor').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class AgendaCategoriaCompromissoGrouped {
	AgendaCategoriaCompromisso? agendaCategoriaCompromisso; 

  AgendaCategoriaCompromissoGrouped({
		this.agendaCategoriaCompromisso, 

  });
}
