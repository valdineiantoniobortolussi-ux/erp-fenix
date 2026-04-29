import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeTransporteVolumeLacre")
class NfeTransporteVolumeLacres extends Table {
	@override
	String get tableName => 'nfe_transporte_volume_lacre';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeTransporteVolume => integer().named('id_nfe_transporte_volume').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 60).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeTransporteVolumeLacreGrouped {
	NfeTransporteVolumeLacre? nfeTransporteVolumeLacre; 
	NfeTransporteVolume? nfeTransporteVolume; 

  NfeTransporteVolumeLacreGrouped({
		this.nfeTransporteVolumeLacre, 
		this.nfeTransporteVolume, 

  });
}
