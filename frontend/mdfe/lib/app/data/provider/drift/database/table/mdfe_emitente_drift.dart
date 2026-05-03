import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeEmitente")
class MdfeEmitentes extends Table {
	@override
	String get tableName => 'mdfe_emitente';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeCabecalho => integer().named('id_mdfe_cabecalho').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 60).nullable()();
	TextColumn get fantasia => text().named('fantasia').withLength(min: 0, max: 60).nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	IntColumn get ie => integer().named('ie').nullable()();
	TextColumn get logradouro => text().named('logradouro').withLength(min: 0, max: 60).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 60).nullable()();
	TextColumn get complemento => text().named('complemento').withLength(min: 0, max: 60).nullable()();
	TextColumn get bairro => text().named('bairro').withLength(min: 0, max: 60).nullable()();
	TextColumn get codigoMunicipio => text().named('codigo_municipio').withLength(min: 0, max: 7).nullable()();
	TextColumn get nomeMunicipio => text().named('nome_municipio').withLength(min: 0, max: 60).nullable()();
	TextColumn get cep => text().named('cep').withLength(min: 0, max: 8).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get telefone => text().named('telefone').withLength(min: 0, max: 12).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 60).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeEmitenteGrouped {
	MdfeEmitente? mdfeEmitente; 

  MdfeEmitenteGrouped({
		this.mdfeEmitente, 

  });
}
