import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/provider/drift/database/database_imports.dart';

@DataClassName("VendaOrcamentoCabecalho")
class VendaOrcamentoCabecalhos extends Table {
	@override
	String get tableName => 'venda_orcamento_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idVendedor => integer().named('id_vendedor').nullable()();
	IntColumn get idCliente => integer().named('id_cliente').nullable()();
	IntColumn get idVendaCondicoesPagamento => integer().named('id_venda_condicoes_pagamento').nullable()();
	IntColumn get idTransportadora => integer().named('id_transportadora').nullable()();
	TextColumn get tipoFrete => text().named('tipo_frete').withLength(min: 0, max: 1).nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 20).nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	DateTimeColumn get dataEntrega => dateTime().named('data_entrega').nullable()();
	DateTimeColumn get dataValidade => dateTime().named('data_validade').nullable()();
	RealColumn get valorSubtotal => real().named('valor_subtotal').nullable()();
	RealColumn get valorFrete => real().named('valor_frete').nullable()();
	RealColumn get taxaComissao => real().named('taxa_comissao').nullable()();
	RealColumn get valorComissao => real().named('valor_comissao').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class VendaOrcamentoCabecalhoGrouped {
	VendaOrcamentoCabecalho? vendaOrcamentoCabecalho; 
	List<VendaOrcamentoDetalheGrouped>? vendaOrcamentoDetalheGroupedList; 
	VendaCondicoesPagamento? vendaCondicoesPagamento; 
	ViewPessoaVendedor? viewPessoaVendedor; 
	ViewPessoaTransportadora? viewPessoaTransportadora; 
	ViewPessoaCliente? viewPessoaCliente; 

  VendaOrcamentoCabecalhoGrouped({
		this.vendaOrcamentoCabecalho, 
		this.vendaOrcamentoDetalheGroupedList, 
		this.vendaCondicoesPagamento, 
		this.viewPessoaVendedor, 
		this.viewPessoaTransportadora, 
		this.viewPessoaCliente, 

  });
}
