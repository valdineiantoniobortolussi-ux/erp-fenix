import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';

@DataClassName("CompraRequisicaoDetalhe")
class CompraRequisicaoDetalhes extends Table {
	@override
	String get tableName => 'compra_requisicao_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCompraRequisicao => integer().named('id_compra_requisicao').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CompraRequisicaoDetalheGrouped {
	CompraRequisicaoDetalhe? compraRequisicaoDetalhe; 
	Produto? produto; 

  CompraRequisicaoDetalheGrouped({
		this.compraRequisicaoDetalhe, 
		this.produto, 

  });
}
