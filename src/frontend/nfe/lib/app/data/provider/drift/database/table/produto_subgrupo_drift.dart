import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

@DataClassName("ProdutoSubgrupo")
class ProdutoSubgrupos extends Table {
	@override
	String get tableName => 'produto_subgrupo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idProdutoGrupo => integer().named('id_produto_grupo').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProdutoSubgrupoGrouped {
	ProdutoSubgrupo? produtoSubgrupo; 
	List<ProdutoGrouped>? produtoGroupedList; 

  ProdutoSubgrupoGrouped({
		this.produtoSubgrupo, 
		this.produtoGroupedList, 

  });
}
