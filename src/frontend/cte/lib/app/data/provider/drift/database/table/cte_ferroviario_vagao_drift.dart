import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteFerroviarioVagao")
class CteFerroviarioVagaos extends Table {
	@override
	String get tableName => 'cte_ferroviario_vagao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteFerroviario => integer().named('id_cte_ferroviario').nullable()();
	IntColumn get numeroVagao => integer().named('numero_vagao').nullable()();
	RealColumn get capacidade => real().named('capacidade').nullable()();
	TextColumn get tipoVagao => text().named('tipo_vagao').withLength(min: 0, max: 3).nullable()();
	RealColumn get pesoReal => real().named('peso_real').nullable()();
	RealColumn get pesoBc => real().named('peso_bc').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteFerroviarioVagaoGrouped {
	CteFerroviarioVagao? cteFerroviarioVagao; 
	CteFerroviario? cteFerroviario; 

  CteFerroviarioVagaoGrouped({
		this.cteFerroviarioVagao, 
		this.cteFerroviario, 

  });
}
