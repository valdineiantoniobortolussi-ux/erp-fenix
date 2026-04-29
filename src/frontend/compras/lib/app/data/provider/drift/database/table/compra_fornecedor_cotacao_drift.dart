import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';

@DataClassName("CompraFornecedorCotacao")
class CompraFornecedorCotacaos extends Table {
	@override
	String get tableName => 'compra_fornecedor_cotacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCompraCotacao => integer().named('id_compra_cotacao').nullable()();
	IntColumn get idFornecedor => integer().named('id_fornecedor').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 32).nullable()();
	TextColumn get prazoEntrega => text().named('prazo_entrega').withLength(min: 0, max: 50).nullable()();
	TextColumn get vendaCondicoesPagamento => text().named('venda_condicoes_pagamento').withLength(min: 0, max: 50).nullable()();
	RealColumn get valorSubtotal => real().named('valor_subtotal').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CompraFornecedorCotacaoGrouped {
	CompraFornecedorCotacao? compraFornecedorCotacao; 
	ViewPessoaFornecedor? viewPessoaFornecedor; 

  CompraFornecedorCotacaoGrouped({
		this.compraFornecedorCotacao, 
		this.viewPessoaFornecedor, 

  });
}
