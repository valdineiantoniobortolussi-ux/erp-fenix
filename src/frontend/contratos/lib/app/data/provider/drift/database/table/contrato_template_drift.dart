import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';

@DataClassName("ContratoTemplate")
class ContratoTemplates extends Table {
	@override
	String get tableName => 'contrato_template';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContratoTemplateGrouped {
	ContratoTemplate? contratoTemplate; 

  ContratoTemplateGrouped({
		this.contratoTemplate, 

  });
}
