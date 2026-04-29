import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteFerroviario")
class CteFerroviarios extends Table {
	@override
	String get tableName => 'cte_ferroviario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get tipoTrafego => text().named('tipo_trafego').withLength(min: 0, max: 1).nullable()();
	TextColumn get responsavelFaturamento => text().named('responsavel_faturamento').withLength(min: 0, max: 1).nullable()();
	TextColumn get ferroviaEmitenteCte => text().named('ferrovia_emitente_cte').withLength(min: 0, max: 1).nullable()();
	TextColumn get fluxo => text().named('fluxo').withLength(min: 0, max: 10).nullable()();
	TextColumn get idTrem => text().named('id_trem').withLength(min: 0, max: 7).nullable()();
	RealColumn get valorFrete => real().named('valor_frete').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteFerroviarioGrouped {
	CteFerroviario? cteFerroviario; 

  CteFerroviarioGrouped({
		this.cteFerroviario, 

  });
}
