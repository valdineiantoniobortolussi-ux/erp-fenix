import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoAbonoUtilizacao")
class PontoAbonoUtilizacaos extends Table {
	@override
	String get tableName => 'ponto_abono_utilizacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPontoAbono => integer().named('id_ponto_abono').nullable()();
	DateTimeColumn get dataUtilizacao => dateTime().named('data_utilizacao').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoAbonoUtilizacaoGrouped {
	PontoAbonoUtilizacao? pontoAbonoUtilizacao; 

  PontoAbonoUtilizacaoGrouped({
		this.pontoAbonoUtilizacao, 

  });
}
