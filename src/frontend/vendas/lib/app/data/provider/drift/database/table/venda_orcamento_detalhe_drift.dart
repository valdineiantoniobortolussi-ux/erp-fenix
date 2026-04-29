import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';

@DataClassName("VendaOrcamentoDetalhe")
class VendaOrcamentoDetalhes extends Table {
	@override
	String get tableName => 'venda_orcamento_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idVendaOrcamentoCabecalho => integer().named('id_venda_orcamento_cabecalho').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();
	RealColumn get valorUnitario => real().named('valor_unitario').nullable()();
	RealColumn get valorSubtotal => real().named('valor_subtotal').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class VendaOrcamentoDetalheGrouped {
	VendaOrcamentoDetalhe? vendaOrcamentoDetalhe; 
	Produto? produto; 

  VendaOrcamentoDetalheGrouped({
		this.vendaOrcamentoDetalhe, 
		this.produto, 

  });
}
