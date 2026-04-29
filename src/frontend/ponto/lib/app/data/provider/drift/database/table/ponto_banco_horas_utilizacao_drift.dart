import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoBancoHorasUtilizacao")
class PontoBancoHorasUtilizacaos extends Table {
	@override
	String get tableName => 'ponto_banco_horas_utilizacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPontoBancoHoras => integer().named('id_ponto_banco_horas').nullable()();
	DateTimeColumn get dataUtilizacao => dateTime().named('data_utilizacao').nullable()();
	TextColumn get quantidadeUtilizada => text().named('quantidade_utilizada').withLength(min: 0, max: 8).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoBancoHorasUtilizacaoGrouped {
	PontoBancoHorasUtilizacao? pontoBancoHorasUtilizacao; 

  PontoBancoHorasUtilizacaoGrouped({
		this.pontoBancoHorasUtilizacao, 

  });
}
