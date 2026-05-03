import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';

@DataClassName("TipoContrato")
class TipoContratos extends Table {
	@override
	String get tableName => 'tipo_contrato';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TipoContratoGrouped {
	TipoContrato? tipoContrato; 

  TipoContratoGrouped({
		this.tipoContrato, 

  });
}
