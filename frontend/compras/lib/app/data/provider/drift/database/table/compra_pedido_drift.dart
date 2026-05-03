import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/provider/drift/database/database_imports.dart';

@DataClassName("CompraPedido")
class CompraPedidos extends Table {
	@override
	String get tableName => 'compra_pedido';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCompraTipoPedido => integer().named('id_compra_tipo_pedido').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idFornecedor => integer().named('id_fornecedor').nullable()();
	TextColumn get codigoCotacao => text().named('codigo_cotacao').withLength(min: 0, max: 32).nullable()();
	DateTimeColumn get dataPedido => dateTime().named('data_pedido').nullable()();
	DateTimeColumn get dataPrevistaEntrega => dateTime().named('data_prevista_entrega').nullable()();
	DateTimeColumn get dataPrevisaoPagamento => dateTime().named('data_previsao_pagamento').nullable()();
	TextColumn get localEntrega => text().named('local_entrega').withLength(min: 0, max: 100).nullable()();
	TextColumn get localCobranca => text().named('local_cobranca').withLength(min: 0, max: 100).nullable()();
	TextColumn get contato => text().named('contato').withLength(min: 0, max: 50).nullable()();
	RealColumn get valorSubtotal => real().named('valor_subtotal').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();
	TextColumn get tipoFrete => text().named('tipo_frete').withLength(min: 0, max: 1).nullable()();
	TextColumn get formaPagamento => text().named('forma_pagamento').withLength(min: 0, max: 1).nullable()();
	RealColumn get baseCalculoIcms => real().named('base_calculo_icms').nullable()();
	RealColumn get valorIcms => real().named('valor_icms').nullable()();
	RealColumn get baseCalculoIcmsSt => real().named('base_calculo_icms_st').nullable()();
	RealColumn get valorIcmsSt => real().named('valor_icms_st').nullable()();
	RealColumn get valorTotalProdutos => real().named('valor_total_produtos').nullable()();
	RealColumn get valorFrete => real().named('valor_frete').nullable()();
	RealColumn get valorSeguro => real().named('valor_seguro').nullable()();
	RealColumn get valorOutrasDespesas => real().named('valor_outras_despesas').nullable()();
	RealColumn get valorIpi => real().named('valor_ipi').nullable()();
	RealColumn get valorTotalNf => real().named('valor_total_nf').nullable()();
	IntColumn get quantidadeParcelas => integer().named('quantidade_parcelas').nullable()();
	TextColumn get diaPrimeiroVencimento => text().named('dia_primeiro_vencimento').withLength(min: 0, max: 2).nullable()();
	IntColumn get intervaloEntreParcelas => integer().named('intervalo_entre_parcelas').nullable()();
	TextColumn get diaFixoParcela => text().named('dia_fixo_parcela').withLength(min: 0, max: 2).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CompraPedidoGrouped {
	CompraPedido? compraPedido; 
	List<CompraPedidoDetalheGrouped>? compraPedidoDetalheGroupedList; 
	CompraTipoPedido? compraTipoPedido; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	ViewPessoaFornecedor? viewPessoaFornecedor; 

  CompraPedidoGrouped({
		this.compraPedido, 
		this.compraPedidoDetalheGroupedList, 
		this.compraTipoPedido, 
		this.viewPessoaColaborador, 
		this.viewPessoaFornecedor, 

  });
}
