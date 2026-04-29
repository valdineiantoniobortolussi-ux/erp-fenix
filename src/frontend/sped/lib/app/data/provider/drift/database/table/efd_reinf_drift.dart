import 'package:drift/drift.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';

@DataClassName("EfdReinf")
class EfdReinfs extends Table {
	@override
	String get tableName => 'efd_reinf';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	DateTimeColumn get periodoInicial => dateTime().named('periodo_inicial').nullable()();
	DateTimeColumn get periodoFinal => dateTime().named('periodo_final').nullable()();
	TextColumn get finalidadeArquivo => text().named('finalidade_arquivo').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EfdReinfGrouped {
	EfdReinf? efdReinf; 

  EfdReinfGrouped({
		this.efdReinf, 

  });
}
