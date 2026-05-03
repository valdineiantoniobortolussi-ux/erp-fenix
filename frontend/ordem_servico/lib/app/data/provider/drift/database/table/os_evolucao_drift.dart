import 'package:drift/drift.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';

@DataClassName("OsEvolucao")
class OsEvolucaos extends Table {
	@override
	String get tableName => 'os_evolucao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idOsAbertura => integer().named('id_os_abertura').nullable()();
	DateTimeColumn get dataRegistro => dateTime().named('data_registro').nullable()();
	TextColumn get horaRegistro => text().named('hora_registro').withLength(min: 0, max: 8).nullable()();
	TextColumn get enviarEmail => text().named('enviar_email').withLength(min: 0, max: 1).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OsEvolucaoGrouped {
	OsEvolucao? osEvolucao; 

  OsEvolucaoGrouped({
		this.osEvolucao, 

  });
}
