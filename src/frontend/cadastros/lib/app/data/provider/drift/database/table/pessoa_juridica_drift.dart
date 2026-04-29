import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("PessoaJuridica")
class PessoaJuridicas extends Table {
	@override
	String get tableName => 'pessoa_juridica';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get nomeFantasia => text().named('nome_fantasia').withLength(min: 0, max: 100).nullable()();
	TextColumn get inscricaoEstadual => text().named('inscricao_estadual').withLength(min: 0, max: 45).nullable()();
	TextColumn get inscricaoMunicipal => text().named('inscricao_municipal').withLength(min: 0, max: 45).nullable()();
	DateTimeColumn get dataConstituicao => dateTime().named('data_constituicao').nullable()();
	TextColumn get tipoRegime => text().named('tipo_regime').withLength(min: 0, max: 1).nullable()();
	TextColumn get crt => text().named('crt').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PessoaJuridicaGrouped {
	PessoaJuridica? pessoaJuridica; 

  PessoaJuridicaGrouped({
		this.pessoaJuridica, 

  });
}
