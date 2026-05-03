import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';

@DataClassName("ProdutoUnidade")
class ProdutoUnidades extends Table {
	@override
	String get tableName => 'produto_unidade';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get sigla => text().named('sigla').withLength(min: 0, max: 10).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();
	TextColumn get podeFracionar => text().named('pode_fracionar').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProdutoUnidadeGrouped {
	ProdutoUnidade? produtoUnidade; 

  ProdutoUnidadeGrouped({
		this.produtoUnidade, 

  });
}
