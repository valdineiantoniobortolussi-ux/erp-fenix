import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDestinatario")
class NfeDestinatarios extends Table {
	@override
	String get tableName => 'nfe_destinatario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get estrangeiroIdentificacao => text().named('estrangeiro_identificacao').withLength(min: 0, max: 20).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 60).nullable()();
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
	TextColumn get indicadorIe => text().named('indicador_ie').withLength(min: 0, max: 1).nullable()();
	TextColumn get inscricaoEstadual => text().named('inscricao_estadual').withLength(min: 0, max: 14).nullable()();
	IntColumn get suframa => integer().named('suframa').nullable()();
	TextColumn get inscricaoMunicipal => text().named('inscricao_municipal').withLength(min: 0, max: 15).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 60).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDestinatarioGrouped {
	NfeDestinatario? nfeDestinatario; 

  NfeDestinatarioGrouped({
		this.nfeDestinatario, 

  });
}
