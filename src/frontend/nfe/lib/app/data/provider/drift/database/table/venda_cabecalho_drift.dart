import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("VendaCabecalho")
class VendaCabecalhos extends Table {
	@override
	String get tableName => 'venda_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idVendaOrcamentoCabecalho => integer().named('id_venda_orcamento_cabecalho').nullable()();
	IntColumn get idVendaCondicoesPagamento => integer().named('id_venda_condicoes_pagamento').nullable()();
	IntColumn get idNotaFiscalTipo => integer().named('id_nota_fiscal_tipo').nullable()();
	IntColumn get idTransportadora => integer().named('id_transportadora').nullable()();
	DateTimeColumn get dataVenda => dateTime().named('data_venda').nullable()();
	DateTimeColumn get dataSaida => dateTime().named('data_saida').nullable()();
	TextColumn get horaSaida => text().named('hora_saida').withLength(min: 0, max: 8).nullable()();
	IntColumn get numeroFatura => integer().named('numero_fatura').nullable()();
	TextColumn get localEntrega => text().named('local_entrega').withLength(min: 0, max: 100).nullable()();
	TextColumn get localCobranca => text().named('local_cobranca').withLength(min: 0, max: 100).nullable()();
	RealColumn get valorSubtotal => real().named('valor_subtotal').nullable()();
	RealColumn get taxaComissao => real().named('taxa_comissao').nullable()();
	RealColumn get valorComissao => real().named('valor_comissao').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();
	TextColumn get tipoFrete => text().named('tipo_frete').withLength(min: 0, max: 1).nullable()();
	TextColumn get formaPagamento => text().named('forma_pagamento').withLength(min: 0, max: 1).nullable()();
	RealColumn get valorFrete => real().named('valor_frete').nullable()();
	RealColumn get valorSeguro => real().named('valor_seguro').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();
	TextColumn get situacao => text().named('situacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get diaFixoParcela => text().named('dia_fixo_parcela').withLength(min: 0, max: 2).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class VendaCabecalhoGrouped {
	VendaCabecalho? vendaCabecalho; 

  VendaCabecalhoGrouped({
		this.vendaCabecalho, 

  });
}
