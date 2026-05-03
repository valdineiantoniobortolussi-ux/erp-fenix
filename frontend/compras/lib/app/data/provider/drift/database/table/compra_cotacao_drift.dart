import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/provider/drift/database/database_imports.dart';

@DataClassName("CompraCotacao")
class CompraCotacaos extends Table {
	@override
	String get tableName => 'compra_cotacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCompraRequisicao => integer().named('id_compra_requisicao').nullable()();
	DateTimeColumn get dataCotacao => dateTime().named('data_cotacao').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CompraCotacaoGrouped {
	CompraCotacao? compraCotacao; 
	List<CompraFornecedorCotacaoGrouped>? compraFornecedorCotacaoGroupedList; 
	CompraRequisicao? compraRequisicao; 
	List<CompraCotacaoDetalheGrouped>? compraCotacaoDetalheGroupedList; 

  CompraCotacaoGrouped({
		this.compraCotacao, 
		this.compraFornecedorCotacaoGroupedList, 
		this.compraRequisicao, 
		this.compraCotacaoDetalheGroupedList, 

  });
}
