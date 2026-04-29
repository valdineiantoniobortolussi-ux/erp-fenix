import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';

@DataClassName("CompraPedidoDetalhe")
class CompraPedidoDetalhes extends Table {
	@override
	String get tableName => 'compra_pedido_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCompraPedido => integer().named('id_compra_pedido').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();
	RealColumn get valorUnitario => real().named('valor_unitario').nullable()();
	RealColumn get valorSubtotal => real().named('valor_subtotal').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();
	TextColumn get cst => text().named('cst').withLength(min: 0, max: 2).nullable()();
	TextColumn get csosn => text().named('csosn').withLength(min: 0, max: 3).nullable()();
	IntColumn get cfop => integer().named('cfop').nullable()();
	RealColumn get baseCalculoIcms => real().named('base_calculo_icms').nullable()();
	RealColumn get valorIcms => real().named('valor_icms').nullable()();
	RealColumn get valorIpi => real().named('valor_ipi').nullable()();
	RealColumn get aliquotaIcms => real().named('aliquota_icms').nullable()();
	RealColumn get aliquotaIpi => real().named('aliquota_ipi').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CompraPedidoDetalheGrouped {
	CompraPedidoDetalhe? compraPedidoDetalhe; 
	Produto? produto; 

  CompraPedidoDetalheGrouped({
		this.compraPedidoDetalhe, 
		this.produto, 

  });
}
