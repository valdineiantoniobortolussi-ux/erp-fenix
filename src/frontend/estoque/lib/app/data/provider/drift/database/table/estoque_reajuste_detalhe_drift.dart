import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';

@DataClassName("EstoqueReajusteDetalhe")
class EstoqueReajusteDetalhes extends Table {
	@override
	String get tableName => 'estoque_reajuste_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idEstoqueReajusteCabecalho => integer().named('id_estoque_reajuste_cabecalho').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	RealColumn get valorOriginal => real().named('valor_original').nullable()();
	RealColumn get valorReajuste => real().named('valor_reajuste').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EstoqueReajusteDetalheGrouped {
	EstoqueReajusteDetalhe? estoqueReajusteDetalhe; 
	Produto? produto; 

  EstoqueReajusteDetalheGrouped({
		this.estoqueReajusteDetalhe, 
		this.produto, 

  });
}
