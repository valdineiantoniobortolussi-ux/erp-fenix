import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoRelogio")
class PontoRelogios extends Table {
	@override
	String get tableName => 'ponto_relogio';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get localizacao => text().named('localizacao').withLength(min: 0, max: 50).nullable()();
	TextColumn get marca => text().named('marca').withLength(min: 0, max: 30).nullable()();
	TextColumn get fabricante => text().named('fabricante').withLength(min: 0, max: 30).nullable()();
	TextColumn get numeroSerie => text().named('numero_serie').withLength(min: 0, max: 50).nullable()();
	TextColumn get utilizacao => text().named('utilizacao').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoRelogioGrouped {
	PontoRelogio? pontoRelogio; 

  PontoRelogioGrouped({
		this.pontoRelogio, 

  });
}
