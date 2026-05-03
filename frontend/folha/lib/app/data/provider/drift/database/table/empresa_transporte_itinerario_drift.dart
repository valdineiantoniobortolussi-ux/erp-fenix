import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("EmpresaTransporteItinerario")
class EmpresaTransporteItinerarios extends Table {
	@override
	String get tableName => 'empresa_transporte_itinerario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idEmpresaTransporte => integer().named('id_empresa_transporte').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	RealColumn get tarifa => real().named('tarifa').nullable()();
	TextColumn get trajeto => text().named('trajeto').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EmpresaTransporteItinerarioGrouped {
	EmpresaTransporteItinerario? empresaTransporteItinerario; 

  EmpresaTransporteItinerarioGrouped({
		this.empresaTransporteItinerario, 

  });
}
