import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';

@DataClassName("Empresa")
class Empresas extends Table {
	@override
	String get tableName => 'empresa';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get razaoSocial => text().named('razao_social').withLength(min: 0, max: 150).nullable()();
	TextColumn get nomeFantasia => text().named('nome_fantasia').withLength(min: 0, max: 150).nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get inscricaoEstadual => text().named('inscricao_estadual').withLength(min: 0, max: 45).nullable()();
	TextColumn get inscricaoMunicipal => text().named('inscricao_municipal').withLength(min: 0, max: 45).nullable()();
	TextColumn get tipoRegime => text().named('tipo_regime').withLength(min: 0, max: 1).nullable()();
	TextColumn get crt => text().named('crt').withLength(min: 0, max: 1).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 250).nullable()();
	TextColumn get site => text().named('site').withLength(min: 0, max: 250).nullable()();
	TextColumn get contato => text().named('contato').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataConstituicao => dateTime().named('data_constituicao').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get inscricaoJuntaComercial => text().named('inscricao_junta_comercial').withLength(min: 0, max: 30).nullable()();
	DateTimeColumn get dataInscJuntaComercial => dateTime().named('data_insc_junta_comercial').nullable()();
	IntColumn get codigoIbgeCidade => integer().named('codigo_ibge_cidade').nullable()();
	IntColumn get codigoIbgeUf => integer().named('codigo_ibge_uf').nullable()();
	TextColumn get cei => text().named('cei').withLength(min: 0, max: 12).nullable()();
	TextColumn get codigoCnaePrincipal => text().named('codigo_cnae_principal').withLength(min: 0, max: 7).nullable()();
	TextColumn get imagemLogotipo => text().named('imagem_logotipo').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EmpresaGrouped {
	Empresa? empresa; 
	List<EmpresaContatoGrouped>? empresaContatoGroupedList; 
	List<EmpresaTelefoneGrouped>? empresaTelefoneGroupedList; 
	List<EmpresaCnaeGrouped>? empresaCnaeGroupedList; 
	List<EmpresaEnderecoGrouped>? empresaEnderecoGroupedList; 

  EmpresaGrouped({
		this.empresa, 
		this.empresaContatoGroupedList, 
		this.empresaTelefoneGroupedList, 
		this.empresaCnaeGroupedList, 
		this.empresaEnderecoGroupedList, 

  });
}
