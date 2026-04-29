import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CtePassagem")
class CtePassagems extends Table {
	@override
	String get tableName => 'cte_passagem';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get siglaPassagem => text().named('sigla_passagem').withLength(min: 0, max: 15).nullable()();
	TextColumn get siglaDestino => text().named('sigla_destino').withLength(min: 0, max: 15).nullable()();
	TextColumn get rota => text().named('rota').withLength(min: 0, max: 10).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CtePassagemGrouped {
	CtePassagem? ctePassagem; 

  CtePassagemGrouped({
		this.ctePassagem, 

  });
}
