import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';

@DataClassName("ContratoHistoricoReajuste")
class ContratoHistoricoReajustes extends Table {
	@override
	String get tableName => 'contrato_historico_reajuste';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContrato => integer().named('id_contrato').nullable()();
	RealColumn get indice => real().named('indice').nullable()();
	RealColumn get valorAnterior => real().named('valor_anterior').nullable()();
	RealColumn get valorAtual => real().named('valor_atual').nullable()();
	DateTimeColumn get dataReajuste => dateTime().named('data_reajuste').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContratoHistoricoReajusteGrouped {
	ContratoHistoricoReajuste? contratoHistoricoReajuste; 

  ContratoHistoricoReajusteGrouped({
		this.contratoHistoricoReajuste, 

  });
}
