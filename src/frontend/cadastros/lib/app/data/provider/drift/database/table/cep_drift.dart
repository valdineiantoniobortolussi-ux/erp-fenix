import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Cep")
class Ceps extends Table {
	@override
	String get tableName => 'cep';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 8).nullable()();
	TextColumn get logradouro => text().named('logradouro').withLength(min: 0, max: 100).nullable()();
	TextColumn get complemento => text().named('complemento').withLength(min: 0, max: 100).nullable()();
	TextColumn get bairro => text().named('bairro').withLength(min: 0, max: 100).nullable()();
	TextColumn get municipio => text().named('municipio').withLength(min: 0, max: 100).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	IntColumn get codigoIbgeMunicipio => integer().named('codigo_ibge_municipio').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CepGrouped {
	Cep? cep; 

  CepGrouped({
		this.cep, 

  });
}
