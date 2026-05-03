import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("PessoaFisica")
class PessoaFisicas extends Table {
	@override
	String get tableName => 'pessoa_fisica';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	IntColumn get idNivelFormacao => integer().named('id_nivel_formacao').nullable()();
	IntColumn get idEstadoCivil => integer().named('id_estado_civil').nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get rg => text().named('rg').withLength(min: 0, max: 20).nullable()();
	TextColumn get orgaoRg => text().named('orgao_rg').withLength(min: 0, max: 20).nullable()();
	DateTimeColumn get dataEmissaoRg => dateTime().named('data_emissao_rg').nullable()();
	DateTimeColumn get dataNascimento => dateTime().named('data_nascimento').nullable()();
	TextColumn get sexo => text().named('sexo').withLength(min: 0, max: 1).nullable()();
	TextColumn get raca => text().named('raca').withLength(min: 0, max: 1).nullable()();
	TextColumn get nacionalidade => text().named('nacionalidade').withLength(min: 0, max: 100).nullable()();
	TextColumn get naturalidade => text().named('naturalidade').withLength(min: 0, max: 100).nullable()();
	TextColumn get nomePai => text().named('nome_pai').withLength(min: 0, max: 200).nullable()();
	TextColumn get nomeMae => text().named('nome_mae').withLength(min: 0, max: 200).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PessoaFisicaGrouped {
	PessoaFisica? pessoaFisica; 
	EstadoCivil? estadoCivil; 
	NivelFormacao? nivelFormacao; 

  PessoaFisicaGrouped({
		this.pessoaFisica, 
		this.estadoCivil, 
		this.nivelFormacao, 

  });
}
