import 'package:drift/drift.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';

@DataClassName("OsAbertura")
class OsAberturas extends Table {
	@override
	String get tableName => 'os_abertura';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idOsStatus => integer().named('id_os_status').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idCliente => integer().named('id_cliente').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	TextColumn get horaInicio => text().named('hora_inicio').withLength(min: 0, max: 8).nullable()();
	DateTimeColumn get dataPrevisao => dateTime().named('data_previsao').nullable()();
	TextColumn get horaPrevisao => text().named('hora_previsao').withLength(min: 0, max: 8).nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	TextColumn get horaFim => text().named('hora_fim').withLength(min: 0, max: 8).nullable()();
	TextColumn get nomeContato => text().named('nome_contato').withLength(min: 0, max: 50).nullable()();
	TextColumn get foneContato => text().named('fone_contato').withLength(min: 0, max: 15).nullable()();
	TextColumn get observacaoCliente => text().named('observacao_cliente').nullable()();
	TextColumn get observacaoAbertura => text().named('observacao_abertura').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OsAberturaGrouped {
	OsAbertura? osAbertura; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	ViewPessoaCliente? viewPessoaCliente; 

  OsAberturaGrouped({
		this.osAbertura, 
		this.viewPessoaColaborador, 
		this.viewPessoaCliente, 

  });
}
