import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';

@DataClassName("OrcamentoDetalhe")
class OrcamentoDetalhes extends Table {
	@override
	String get tableName => 'orcamento_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idOrcamentoEmpresarial => integer().named('id_orcamento_empresarial').nullable()();
	IntColumn get idFinNaturezaFinanceira => integer().named('id_fin_natureza_financeira').nullable()();
	TextColumn get periodo => text().named('periodo').withLength(min: 0, max: 10).nullable()();
	RealColumn get valorOrcado => real().named('valor_orcado').nullable()();
	RealColumn get valorRealizado => real().named('valor_realizado').nullable()();
	RealColumn get taxaVariacao => real().named('taxa_variacao').nullable()();
	RealColumn get valorVariacao => real().named('valor_variacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OrcamentoDetalheGrouped {
	OrcamentoDetalhe? orcamentoDetalhe; 
	FinNaturezaFinanceira? finNaturezaFinanceira; 

  OrcamentoDetalheGrouped({
		this.orcamentoDetalhe, 
		this.finNaturezaFinanceira, 

  });
}
