import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaVeiculoTipo")
class FrotaVeiculoTipos extends Table {
	@override
	String get tableName => 'frota_veiculo_tipo';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaVeiculoTipoGrouped {
	FrotaVeiculoTipo? frotaVeiculoTipo; 

  FrotaVeiculoTipoGrouped({
		this.frotaVeiculoTipo, 

  });
}
