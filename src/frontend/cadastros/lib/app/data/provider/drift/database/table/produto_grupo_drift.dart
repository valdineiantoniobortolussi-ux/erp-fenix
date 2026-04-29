import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("ProdutoGrupo")
class ProdutoGrupos extends Table {
	@override
	String get tableName => 'produto_grupo';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProdutoGrupoGrouped {
	ProdutoGrupo? produtoGrupo; 

  ProdutoGrupoGrouped({
		this.produtoGrupo, 

  });
}
