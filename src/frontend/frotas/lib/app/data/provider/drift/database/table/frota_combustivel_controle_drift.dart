import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaCombustivelControle")
class FrotaCombustivelControles extends Table {
	@override
	String get tableName => 'frota_combustivel_controle';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFrotaVeiculo => integer().named('id_frota_veiculo').nullable()();
	DateTimeColumn get dataAbastecimento => dateTime().named('data_abastecimento').nullable()();
	TextColumn get horaAbastecimento => text().named('hora_abastecimento').withLength(min: 0, max: 8).nullable()();
	RealColumn get valorAbastecimento => real().named('valor_abastecimento').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaCombustivelControleGrouped {
	FrotaCombustivelControle? frotaCombustivelControle; 

  FrotaCombustivelControleGrouped({
		this.frotaCombustivelControle, 

  });
}
