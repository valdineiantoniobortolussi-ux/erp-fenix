import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/provider/drift/database/database_imports.dart';

@DataClassName("RecadoRemetente")
class RecadoRemetentes extends Table {
	@override
	String get tableName => 'recado_remetente';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataEnvio => dateTime().named('data_envio').nullable()();
	TextColumn get horaEnvio => text().named('hora_envio').withLength(min: 0, max: 8).nullable()();
	TextColumn get assunto => text().named('assunto').withLength(min: 0, max: 100).nullable()();
	TextColumn get texto => text().named('texto').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class RecadoRemetenteGrouped {
	RecadoRemetente? recadoRemetente; 
	List<RecadoDestinatarioGrouped>? recadoDestinatarioGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  RecadoRemetenteGrouped({
		this.recadoRemetente, 
		this.recadoDestinatarioGroupedList, 
		this.viewPessoaColaborador, 

  });
}
