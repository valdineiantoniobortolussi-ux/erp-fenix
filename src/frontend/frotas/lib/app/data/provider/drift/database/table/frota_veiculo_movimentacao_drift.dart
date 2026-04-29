import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaVeiculoMovimentacao")
class FrotaVeiculoMovimentacaos extends Table {
	@override
	String get tableName => 'frota_veiculo_movimentacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFrotaVeiculo => integer().named('id_frota_veiculo').nullable()();
	IntColumn get idFrotaMotorista => integer().named('id_frota_motorista').nullable()();
	DateTimeColumn get dataSaida => dateTime().named('data_saida').nullable()();
	TextColumn get horaSaida => text().named('hora_saida').withLength(min: 0, max: 8).nullable()();
	DateTimeColumn get dataEntrada => dateTime().named('data_entrada').nullable()();
	TextColumn get horaEntrada => text().named('hora_entrada').withLength(min: 0, max: 8).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaVeiculoMovimentacaoGrouped {
	FrotaVeiculoMovimentacao? frotaVeiculoMovimentacao; 
	FrotaMotorista? frotaMotorista; 

  FrotaVeiculoMovimentacaoGrouped({
		this.frotaVeiculoMovimentacao, 
		this.frotaMotorista, 

  });
}
