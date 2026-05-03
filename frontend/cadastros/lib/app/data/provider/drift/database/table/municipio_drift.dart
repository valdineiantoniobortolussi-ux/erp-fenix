import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Municipio")
class Municipios extends Table {
	@override
	String get tableName => 'municipio';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idUf => integer().named('id_uf').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	IntColumn get codigoIbge => integer().named('codigo_ibge').nullable()();
	IntColumn get codigoReceitaFederal => integer().named('codigo_receita_federal').nullable()();
	IntColumn get codigoEstadual => integer().named('codigo_estadual').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MunicipioGrouped {
	Municipio? municipio; 
	Uf? uf; 

  MunicipioGrouped({
		this.municipio, 
		this.uf, 

  });
}
