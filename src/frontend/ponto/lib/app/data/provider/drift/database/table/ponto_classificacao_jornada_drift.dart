import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoClassificacaoJornada")
class PontoClassificacaoJornadas extends Table {
	@override
	String get tableName => 'ponto_classificacao_jornada';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	TextColumn get padrao => text().named('padrao').withLength(min: 0, max: 1).nullable()();
	TextColumn get descontarHoras => text().named('descontar_horas').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoClassificacaoJornadaGrouped {
	PontoClassificacaoJornada? pontoClassificacaoJornada; 

  PontoClassificacaoJornadaGrouped({
		this.pontoClassificacaoJornada, 

  });
}
