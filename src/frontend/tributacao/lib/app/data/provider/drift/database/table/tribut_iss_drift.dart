import 'package:drift/drift.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';

@DataClassName("TributIss")
class TributIsss extends Table {
	@override
	String get tableName => 'tribut_iss';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idTributOperacaoFiscal => integer().named('id_tribut_operacao_fiscal').nullable()();
	TextColumn get modalidadeBaseCalculo => text().named('modalidade_base_calculo').withLength(min: 0, max: 1).nullable()();
	TextColumn get codigoTributacao => text().named('codigo_tributacao').withLength(min: 0, max: 1).nullable()();
	IntColumn get itemListaServico => integer().named('item_lista_servico').nullable()();
	RealColumn get porcentoBaseCalculo => real().named('porcento_base_calculo').nullable()();
	RealColumn get aliquotaPorcento => real().named('aliquota_porcento').nullable()();
	RealColumn get aliquotaUnidade => real().named('aliquota_unidade').nullable()();
	RealColumn get valorPrecoMaximo => real().named('valor_preco_maximo').nullable()();
	RealColumn get valorPautaFiscal => real().named('valor_pauta_fiscal').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TributIssGrouped {
	TributIss? tributIss; 
	TributOperacaoFiscal? tributOperacaoFiscal; 

  TributIssGrouped({
		this.tributIss, 
		this.tributOperacaoFiscal, 

  });
}
