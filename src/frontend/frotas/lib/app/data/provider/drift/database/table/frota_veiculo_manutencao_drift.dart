import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaVeiculoManutencao")
class FrotaVeiculoManutencaos extends Table {
	@override
	String get tableName => 'frota_veiculo_manutencao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFrotaVeiculo => integer().named('id_frota_veiculo').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataManutencao => dateTime().named('data_manutencao').nullable()();
	RealColumn get valorManutencao => real().named('valor_manutencao').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaVeiculoManutencaoGrouped {
	FrotaVeiculoManutencao? frotaVeiculoManutencao; 

  FrotaVeiculoManutencaoGrouped({
		this.frotaVeiculoManutencao, 

  });
}
