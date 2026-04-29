import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaMultaControle")
class FrotaMultaControles extends Table {
	@override
	String get tableName => 'frota_multa_controle';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFrotaVeiculo => integer().named('id_frota_veiculo').nullable()();
	DateTimeColumn get dataMulta => dateTime().named('data_multa').nullable()();
	IntColumn get pontos => integer().named('pontos').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaMultaControleGrouped {
	FrotaMultaControle? frotaMultaControle; 

  FrotaMultaControleGrouped({
		this.frotaMultaControle, 

  });
}
