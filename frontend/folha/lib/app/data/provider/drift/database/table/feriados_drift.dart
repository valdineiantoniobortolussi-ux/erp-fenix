import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("Feriados")
class Feriadoss extends Table {
	@override
	String get tableName => 'feriados';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get ano => text().named('ano').withLength(min: 0, max: 4).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get abrangencia => text().named('abrangencia').withLength(min: 0, max: 1).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	IntColumn get municipioIbge => integer().named('municipio_ibge').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataFeriado => dateTime().named('data_feriado').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FeriadosGrouped {
	Feriados? feriados; 

  FeriadosGrouped({
		this.feriados, 

  });
}
