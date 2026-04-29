import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

@DataClassName("ProdutoMarca")
class ProdutoMarcas extends Table {
	@override
	String get tableName => 'produto_marca';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProdutoMarcaGrouped {
	ProdutoMarca? produtoMarca; 
	List<ProdutoGrouped>? produtoGroupedList; 

  ProdutoMarcaGrouped({
		this.produtoMarca, 
		this.produtoGroupedList, 

  });
}
