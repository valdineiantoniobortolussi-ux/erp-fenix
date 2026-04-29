import 'package:drift/drift.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';

@DataClassName("Sintegra")
class Sintegras extends Table {
	@override
	String get tableName => 'sintegra';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	DateTimeColumn get periodoInicial => dateTime().named('periodo_inicial').nullable()();
	DateTimeColumn get periodoFinal => dateTime().named('periodo_final').nullable()();
	TextColumn get codigoConvenio => text().named('codigo_convenio').withLength(min: 0, max: 1).nullable()();
	TextColumn get finalidadeArquivo => text().named('finalidade_arquivo').withLength(min: 0, max: 100).nullable()();
	TextColumn get inventario => text().named('inventario').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class SintegraGrouped {
	Sintegra? sintegra; 

  SintegraGrouped({
		this.sintegra, 

  });
}
