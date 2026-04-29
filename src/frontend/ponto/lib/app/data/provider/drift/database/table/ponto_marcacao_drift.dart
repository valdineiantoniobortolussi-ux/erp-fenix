import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoMarcacao")
class PontoMarcacaos extends Table {
	@override
	String get tableName => 'ponto_marcacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPontoRelogio => integer().named('id_ponto_relogio').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get nsr => integer().named('nsr').nullable()();
	DateTimeColumn get dataMarcacao => dateTime().named('data_marcacao').nullable()();
	TextColumn get horaMarcacao => text().named('hora_marcacao').withLength(min: 0, max: 8).nullable()();
	TextColumn get tipoMarcacao => text().named('tipo_marcacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipoRegistro => text().named('tipo_registro').withLength(min: 0, max: 1).nullable()();
	TextColumn get parEntradaSaida => text().named('par_entrada_saida').withLength(min: 0, max: 2).nullable()();
	TextColumn get justificativa => text().named('justificativa').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoMarcacaoGrouped {
	PontoMarcacao? pontoMarcacao; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	PontoRelogio? pontoRelogio; 

  PontoMarcacaoGrouped({
		this.pontoMarcacao, 
		this.viewPessoaColaborador, 
		this.pontoRelogio, 

  });
}
