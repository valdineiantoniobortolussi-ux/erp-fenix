import 'package:drift/drift.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';

@DataClassName("GondolaArmazenamento")
class GondolaArmazenamentos extends Table {
	@override
	String get tableName => 'gondola_armazenamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idGondolaCaixa => integer().named('id_gondola_caixa').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	IntColumn get quantidade => integer().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GondolaArmazenamentoGrouped {
	GondolaArmazenamento? gondolaArmazenamento; 
	Produto? produto; 

  GondolaArmazenamentoGrouped({
		this.gondolaArmazenamento, 
		this.produto, 

  });
}
