import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoIssqn")
class NfeDetalheImpostoIssqns extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_issqn';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	RealColumn get baseCalculoIssqn => real().named('base_calculo_issqn').nullable()();
	RealColumn get aliquotaIssqn => real().named('aliquota_issqn').nullable()();
	RealColumn get valorIssqn => real().named('valor_issqn').nullable()();
	IntColumn get municipioIssqn => integer().named('municipio_issqn').nullable()();
	IntColumn get itemListaServicos => integer().named('item_lista_servicos').nullable()();
	RealColumn get valorDeducao => real().named('valor_deducao').nullable()();
	RealColumn get valorOutrasRetencoes => real().named('valor_outras_retencoes').nullable()();
	RealColumn get valorDescontoIncondicionado => real().named('valor_desconto_incondicionado').nullable()();
	RealColumn get valorDescontoCondicionado => real().named('valor_desconto_condicionado').nullable()();
	RealColumn get valorRetencaoIss => real().named('valor_retencao_iss').nullable()();
	TextColumn get indicadorExigibilidadeIss => text().named('indicador_exigibilidade_iss').withLength(min: 0, max: 1).nullable()();
	TextColumn get codigoServico => text().named('codigo_servico').withLength(min: 0, max: 20).nullable()();
	IntColumn get municipioIncidencia => integer().named('municipio_incidencia').nullable()();
	IntColumn get paisSevicoPrestado => integer().named('pais_sevico_prestado').nullable()();
	TextColumn get numeroProcesso => text().named('numero_processo').withLength(min: 0, max: 30).nullable()();
	TextColumn get indicadorIncentivoFiscal => text().named('indicador_incentivo_fiscal').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoIssqnGrouped {
	NfeDetalheImpostoIssqn? nfeDetalheImpostoIssqn; 

  NfeDetalheImpostoIssqnGrouped({
		this.nfeDetalheImpostoIssqn, 

  });
}
