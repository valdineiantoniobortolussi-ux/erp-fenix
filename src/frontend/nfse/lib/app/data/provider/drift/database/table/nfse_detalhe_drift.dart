import 'package:drift/drift.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';

@DataClassName("NfseDetalhe")
class NfseDetalhes extends Table {
	@override
	String get tableName => 'nfse_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfseCabecalho => integer().named('id_nfse_cabecalho').nullable()();
	IntColumn get idNfseListaServico => integer().named('id_nfse_lista_servico').nullable()();
	TextColumn get codigoCnae => text().named('codigo_cnae').withLength(min: 0, max: 7).nullable()();
	TextColumn get codigoTributacaoMunicipio => text().named('codigo_tributacao_municipio').withLength(min: 0, max: 20).nullable()();
	RealColumn get valorServicos => real().named('valor_servicos').nullable()();
	RealColumn get valorDeducoes => real().named('valor_deducoes').nullable()();
	RealColumn get valorPis => real().named('valor_pis').nullable()();
	RealColumn get valorCofins => real().named('valor_cofins').nullable()();
	RealColumn get valorInss => real().named('valor_inss').nullable()();
	RealColumn get valorIr => real().named('valor_ir').nullable()();
	RealColumn get valorCsll => real().named('valor_csll').nullable()();
	RealColumn get valorBaseCalculo => real().named('valor_base_calculo').nullable()();
	RealColumn get aliquota => real().named('aliquota').nullable()();
	RealColumn get valorIss => real().named('valor_iss').nullable()();
	RealColumn get valorLiquido => real().named('valor_liquido').nullable()();
	RealColumn get outrasRetencoes => real().named('outras_retencoes').nullable()();
	RealColumn get valorCredito => real().named('valor_credito').nullable()();
	TextColumn get issRetido => text().named('iss_retido').withLength(min: 0, max: 1).nullable()();
	RealColumn get valorIssRetido => real().named('valor_iss_retido').nullable()();
	RealColumn get valorDescontoCondicionado => real().named('valor_desconto_condicionado').nullable()();
	RealColumn get valorDescontoIncondicionado => real().named('valor_desconto_incondicionado').nullable()();
	IntColumn get municipioPrestacao => integer().named('municipio_prestacao').nullable()();
	TextColumn get discriminacao => text().named('discriminacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfseDetalheGrouped {
	NfseDetalhe? nfseDetalhe; 
	NfseListaServico? nfseListaServico; 

  NfseDetalheGrouped({
		this.nfseDetalhe, 
		this.nfseListaServico, 

  });
}
