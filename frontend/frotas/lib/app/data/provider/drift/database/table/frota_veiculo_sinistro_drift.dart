import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaVeiculoSinistro")
class FrotaVeiculoSinistros extends Table {
	@override
	String get tableName => 'frota_veiculo_sinistro';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFrotaVeiculo => integer().named('id_frota_veiculo').nullable()();
	DateTimeColumn get dataSinistro => dateTime().named('data_sinistro').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaVeiculoSinistroGrouped {
	FrotaVeiculoSinistro? frotaVeiculoSinistro; 

  FrotaVeiculoSinistroGrouped({
		this.frotaVeiculoSinistro, 

  });
}
