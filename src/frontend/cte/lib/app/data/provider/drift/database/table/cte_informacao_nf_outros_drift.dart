import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteInformacaoNfOutros")
class CteInformacaoNfOutross extends Table {
	@override
	String get tableName => 'cte_informacao_nf_outros';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get numeroRomaneio => text().named('numero_romaneio').withLength(min: 0, max: 20).nullable()();
	TextColumn get numeroPedido => text().named('numero_pedido').withLength(min: 0, max: 20).nullable()();
	TextColumn get chaveAcessoNfe => text().named('chave_acesso_nfe').withLength(min: 0, max: 44).nullable()();
	TextColumn get codigoModelo => text().named('codigo_modelo').withLength(min: 0, max: 2).nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	IntColumn get ufEmitente => integer().named('uf_emitente').nullable()();
	RealColumn get baseCalculoIcms => real().named('base_calculo_icms').nullable()();
	RealColumn get valorIcms => real().named('valor_icms').nullable()();
	RealColumn get baseCalculoIcmsSt => real().named('base_calculo_icms_st').nullable()();
	RealColumn get valorIcmsSt => real().named('valor_icms_st').nullable()();
	RealColumn get valorTotalProdutos => real().named('valor_total_produtos').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();
	IntColumn get cfopPredominante => integer().named('cfop_predominante').nullable()();
	RealColumn get pesoTotalKg => real().named('peso_total_kg').nullable()();
	IntColumn get pinSuframa => integer().named('pin_suframa').nullable()();
	DateTimeColumn get dataPrevistaEntrega => dateTime().named('data_prevista_entrega').nullable()();
	TextColumn get outroTipoDocOrig => text().named('outro_tipo_doc_orig').withLength(min: 0, max: 2).nullable()();
	TextColumn get outroDescricao => text().named('outro_descricao').withLength(min: 0, max: 100).nullable()();
	RealColumn get outroValorDocumento => real().named('outro_valor_documento').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteInformacaoNfOutrosGrouped {
	CteInformacaoNfOutros? cteInformacaoNfOutros; 

  CteInformacaoNfOutrosGrouped({
		this.cteInformacaoNfOutros, 

  });
}
