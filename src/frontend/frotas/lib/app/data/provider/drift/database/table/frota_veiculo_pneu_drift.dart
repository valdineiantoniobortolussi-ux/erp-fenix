import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaVeiculoPneu")
class FrotaVeiculoPneus extends Table {
	@override
	String get tableName => 'frota_veiculo_pneu';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFrotaVeiculo => integer().named('id_frota_veiculo').nullable()();
	DateTimeColumn get dataTroca => dateTime().named('data_troca').nullable()();
	RealColumn get valorTroca => real().named('valor_troca').nullable()();
	TextColumn get posicaoPneu => text().named('posicao_pneu').withLength(min: 0, max: 100).nullable()();
	TextColumn get marcaPneu => text().named('marca_pneu').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaVeiculoPneuGrouped {
	FrotaVeiculoPneu? frotaVeiculoPneu; 

  FrotaVeiculoPneuGrouped({
		this.frotaVeiculoPneu, 

  });
}
