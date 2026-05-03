import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("GuiasAcumuladas")
class GuiasAcumuladass extends Table {
	@override
	String get tableName => 'guias_acumuladas';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get gpsTipo => text().named('gps_tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get gpsCompetencia => text().named('gps_competencia').withLength(min: 0, max: 7).nullable()();
	RealColumn get gpsValorInss => real().named('gps_valor_inss').nullable()();
	RealColumn get gpsValorOutrasEnt => real().named('gps_valor_outras_ent').nullable()();
	DateTimeColumn get gpsDataPagamento => dateTime().named('gps_data_pagamento').nullable()();
	TextColumn get irrfCompetencia => text().named('irrf_competencia').withLength(min: 0, max: 7).nullable()();
	IntColumn get irrfCodigoRecolhimento => integer().named('irrf_codigo_recolhimento').nullable()();
	RealColumn get irrfValorAcumulado => real().named('irrf_valor_acumulado').nullable()();
	DateTimeColumn get irrfDataPagamento => dateTime().named('irrf_data_pagamento').nullable()();
	TextColumn get pisCompetencia => text().named('pis_competencia').withLength(min: 0, max: 7).nullable()();
	RealColumn get pisValorAcumulado => real().named('pis_valor_acumulado').nullable()();
	DateTimeColumn get pisDataPagamento => dateTime().named('pis_data_pagamento').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GuiasAcumuladasGrouped {
	GuiasAcumuladas? guiasAcumuladas; 

  GuiasAcumuladasGrouped({
		this.guiasAcumuladas, 

  });
}
