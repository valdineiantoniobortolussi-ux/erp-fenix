import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("AidfAimdf")
class AidfAimdfs extends Table {
	@override
	String get tableName => 'aidf_aimdf';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get numero => integer().named('numero').nullable()();
	DateTimeColumn get dataValidade => dateTime().named('data_validade').nullable()();
	DateTimeColumn get dataAutorizacao => dateTime().named('data_autorizacao').nullable()();
	TextColumn get numeroAutorizacao => text().named('numero_autorizacao').withLength(min: 0, max: 20).nullable()();
	TextColumn get formularioDisponivel => text().named('formulario_disponivel').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class AidfAimdfGrouped {
	AidfAimdf? aidfAimdf; 

  AidfAimdfGrouped({
		this.aidfAimdf, 

  });
}
