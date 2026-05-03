import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteCarga")
class CteCargas extends Table {
	@override
	String get tableName => 'cte_carga';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get codigoUnidadeMedida => text().named('codigo_unidade_medida').withLength(min: 0, max: 2).nullable()();
	TextColumn get tipoMedida => text().named('tipo_medida').withLength(min: 0, max: 20).nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteCargaGrouped {
	CteCarga? cteCarga; 

  CteCargaGrouped({
		this.cteCarga, 

  });
}
