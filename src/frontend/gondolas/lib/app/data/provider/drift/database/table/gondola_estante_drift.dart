import 'package:drift/drift.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';

@DataClassName("GondolaEstante")
class GondolaEstantes extends Table {
	@override
	String get tableName => 'gondola_estante';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idGondolaRua => integer().named('id_gondola_rua').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 10).nullable()();
	IntColumn get quantidadeCaixa => integer().named('quantidade_caixa').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GondolaEstanteGrouped {
	GondolaEstante? gondolaEstante; 
	GondolaRua? gondolaRua; 

  GondolaEstanteGrouped({
		this.gondolaEstante, 
		this.gondolaRua, 

  });
}
