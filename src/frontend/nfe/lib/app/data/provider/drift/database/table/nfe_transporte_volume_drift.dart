import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeTransporteVolume")
class NfeTransporteVolumes extends Table {
	@override
	String get tableName => 'nfe_transporte_volume';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeTransporte => integer().named('id_nfe_transporte').nullable()();
	IntColumn get quantidade => integer().named('quantidade').nullable()();
	TextColumn get especie => text().named('especie').withLength(min: 0, max: 60).nullable()();
	TextColumn get marca => text().named('marca').withLength(min: 0, max: 60).nullable()();
	TextColumn get numeracao => text().named('numeracao').withLength(min: 0, max: 60).nullable()();
	RealColumn get pesoLiquido => real().named('peso_liquido').nullable()();
	RealColumn get pesoBruto => real().named('peso_bruto').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeTransporteVolumeGrouped {
	NfeTransporteVolume? nfeTransporteVolume; 
	NfeTransporte? nfeTransporte; 

  NfeTransporteVolumeGrouped({
		this.nfeTransporteVolume, 
		this.nfeTransporte, 

  });
}
