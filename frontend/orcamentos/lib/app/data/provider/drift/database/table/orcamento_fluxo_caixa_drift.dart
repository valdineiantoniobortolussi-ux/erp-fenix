import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';

@DataClassName("OrcamentoFluxoCaixa")
class OrcamentoFluxoCaixas extends Table {
	@override
	String get tableName => 'orcamento_fluxo_caixa';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idOrcFluxoCaixaPeriodo => integer().named('id_orc_fluxo_caixa_periodo').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 30).nullable()();
	DateTimeColumn get dataInicial => dateTime().named('data_inicial').nullable()();
	IntColumn get numeroPeriodos => integer().named('numero_periodos').nullable()();
	DateTimeColumn get dataBase => dateTime().named('data_base').nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OrcamentoFluxoCaixaGrouped {
	OrcamentoFluxoCaixa? orcamentoFluxoCaixa; 
	List<OrcamentoFluxoCaixaDetalheGrouped>? orcamentoFluxoCaixaDetalheGroupedList; 
	OrcamentoFluxoCaixaPeriodo? orcamentoFluxoCaixaPeriodo; 

  OrcamentoFluxoCaixaGrouped({
		this.orcamentoFluxoCaixa, 
		this.orcamentoFluxoCaixaDetalheGroupedList, 
		this.orcamentoFluxoCaixaPeriodo, 

  });
}
