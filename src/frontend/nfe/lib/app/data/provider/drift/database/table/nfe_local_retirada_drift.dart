import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeLocalRetirada")
class NfeLocalRetiradas extends Table {
	@override
	String get tableName => 'nfe_local_retirada';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get nomeExpedidor => text().named('nome_expedidor').withLength(min: 0, max: 60).nullable()();
	TextColumn get logradouro => text().named('logradouro').withLength(min: 0, max: 60).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 60).nullable()();
	TextColumn get complemento => text().named('complemento').withLength(min: 0, max: 60).nullable()();
	TextColumn get bairro => text().named('bairro').withLength(min: 0, max: 60).nullable()();
	IntColumn get codigoMunicipio => integer().named('codigo_municipio').nullable()();
	TextColumn get nomeMunicipio => text().named('nome_municipio').withLength(min: 0, max: 60).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get cep => text().named('cep').withLength(min: 0, max: 8).nullable()();
	IntColumn get codigoPais => integer().named('codigo_pais').nullable()();
	TextColumn get nomePais => text().named('nome_pais').withLength(min: 0, max: 60).nullable()();
	TextColumn get telefone => text().named('telefone').withLength(min: 0, max: 14).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 60).nullable()();
	TextColumn get inscricaoEstadual => text().named('inscricao_estadual').withLength(min: 0, max: 14).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeLocalRetiradaGrouped {
	NfeLocalRetirada? nfeLocalRetirada; 

  NfeLocalRetiradaGrouped({
		this.nfeLocalRetirada, 

  });
}
