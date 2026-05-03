import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';

@DataClassName("OrcamentoFluxoCaixaPeriodo")
class OrcamentoFluxoCaixaPeriodos extends Table {
	@override
	String get tableName => 'orcamento_fluxo_caixa_periodo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idBancoContaCaixa => integer().named('id_banco_conta_caixa').nullable()();
	TextColumn get periodo => text().named('periodo').withLength(min: 0, max: 1).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 30).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OrcamentoFluxoCaixaPeriodoGrouped {
	OrcamentoFluxoCaixaPeriodo? orcamentoFluxoCaixaPeriodo; 
	BancoContaCaixa? bancoContaCaixa; 

  OrcamentoFluxoCaixaPeriodoGrouped({
		this.orcamentoFluxoCaixaPeriodo, 
		this.bancoContaCaixa, 

  });
}
