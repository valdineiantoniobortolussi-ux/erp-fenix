import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';

@DataClassName("ContratoTipoServico")
class ContratoTipoServicos extends Table {
	@override
	String get tableName => 'contrato_tipo_servico';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContratoTipoServicoGrouped {
	ContratoTipoServico? contratoTipoServico; 

  ContratoTipoServicoGrouped({
		this.contratoTipoServico, 

  });
}
