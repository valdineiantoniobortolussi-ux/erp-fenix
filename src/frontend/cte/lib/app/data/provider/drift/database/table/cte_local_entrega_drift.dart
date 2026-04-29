import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteLocalEntrega")
class CteLocalEntregas extends Table {
	@override
	String get tableName => 'cte_local_entrega';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 60).nullable()();
	TextColumn get logradouro => text().named('logradouro').withLength(min: 0, max: 250).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 60).nullable()();
	TextColumn get complemento => text().named('complemento').withLength(min: 0, max: 60).nullable()();
	TextColumn get bairro => text().named('bairro').withLength(min: 0, max: 60).nullable()();
	IntColumn get codigoMunicipio => integer().named('codigo_municipio').nullable()();
	TextColumn get nomeMunicipio => text().named('nome_municipio').withLength(min: 0, max: 60).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteLocalEntregaGrouped {
	CteLocalEntrega? cteLocalEntrega; 

  CteLocalEntregaGrouped({
		this.cteLocalEntrega, 

  });
}
