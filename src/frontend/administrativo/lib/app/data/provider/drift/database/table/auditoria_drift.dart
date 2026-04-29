import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';

@DataClassName("Auditoria")
class Auditorias extends Table {
	@override
	String get tableName => 'auditoria';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataRegistro => dateTime().named('data_registro').nullable()();
	TextColumn get horaRegistro => text().named('hora_registro').withLength(min: 0, max: 8).nullable()();
	TextColumn get janelaController => text().named('janela_controller').withLength(min: 0, max: 250).nullable()();
	TextColumn get acao => text().named('acao').withLength(min: 0, max: 50).nullable()();
	TextColumn get conteudo => text().named('conteudo').nullable()();
	TextColumn get tokenJwt => text().named('token_jwt').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class AuditoriaGrouped {
	Auditoria? auditoria; 

  AuditoriaGrouped({
		this.auditoria, 

  });
}
