import 'package:drift/drift.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';
import 'package:gondolas/app/data/provider/drift/database/database_imports.dart';

@DataClassName("GondolaCaixa")
class GondolaCaixas extends Table {
	@override
	String get tableName => 'gondola_caixa';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idGondolaEstante => integer().named('id_gondola_estante').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 10).nullable()();
	IntColumn get altura => integer().named('altura').nullable()();
	IntColumn get largura => integer().named('largura').nullable()();
	IntColumn get profundidade => integer().named('profundidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GondolaCaixaGrouped {
	GondolaCaixa? gondolaCaixa; 
	List<GondolaArmazenamentoGrouped>? gondolaArmazenamentoGroupedList; 
	GondolaEstante? gondolaEstante; 

  GondolaCaixaGrouped({
		this.gondolaCaixa, 
		this.gondolaArmazenamentoGroupedList, 
		this.gondolaEstante, 

  });
}
