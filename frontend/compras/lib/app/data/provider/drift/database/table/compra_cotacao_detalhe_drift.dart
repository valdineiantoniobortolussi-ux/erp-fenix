import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';

@DataClassName("CompraCotacaoDetalhe")
class CompraCotacaoDetalhes extends Table {
	@override
	String get tableName => 'compra_cotacao_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	IntColumn get idCompraCotacao => integer().named('id_compra_cotacao').nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();
	RealColumn get valorUnitario => real().named('valor_unitario').nullable()();
	RealColumn get valorSubtotal => real().named('valor_subtotal').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CompraCotacaoDetalheGrouped {
	CompraCotacaoDetalhe? compraCotacaoDetalhe; 
	Produto? produto; 

  CompraCotacaoDetalheGrouped({
		this.compraCotacaoDetalhe, 
		this.produto, 

  });
}
