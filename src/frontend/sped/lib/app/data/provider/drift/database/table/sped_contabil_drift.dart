import 'package:drift/drift.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';

@DataClassName("SpedContabil")
class SpedContabils extends Table {
	@override
	String get tableName => 'sped_contabil';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	DateTimeColumn get periodoInicial => dateTime().named('periodo_inicial').nullable()();
	DateTimeColumn get periodoFinal => dateTime().named('periodo_final').nullable()();
	TextColumn get formaEscrituracao => text().named('forma_escrituracao').withLength(min: 0, max: 1).nullable()();
	TextColumn get versaoLayout => text().named('versao_layout').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class SpedContabilGrouped {
	SpedContabil? spedContabil; 

  SpedContabilGrouped({
		this.spedContabil, 

  });
}
