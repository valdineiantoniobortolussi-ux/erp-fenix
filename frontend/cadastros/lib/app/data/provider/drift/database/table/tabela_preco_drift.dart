import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("TabelaPreco")
class TabelaPrecos extends Table {
	@override
	String get tableName => 'tabela_preco';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get principal => text().named('principal').withLength(min: 0, max: 1).nullable()();
	RealColumn get coeficiente => real().named('coeficiente').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TabelaPrecoGrouped {
	TabelaPreco? tabelaPreco; 

  TabelaPrecoGrouped({
		this.tabelaPreco, 

  });
}
