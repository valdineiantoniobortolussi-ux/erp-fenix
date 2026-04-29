import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteSeguro")
class CteSeguros extends Table {
	@override
	String get tableName => 'cte_seguro';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get responsavel => text().named('responsavel').withLength(min: 0, max: 1).nullable()();
	TextColumn get seguradora => text().named('seguradora').withLength(min: 0, max: 30).nullable()();
	TextColumn get apolice => text().named('apolice').withLength(min: 0, max: 20).nullable()();
	TextColumn get averbacao => text().named('averbacao').withLength(min: 0, max: 20).nullable()();
	RealColumn get valorCarga => real().named('valor_carga').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteSeguroGrouped {
	CteSeguro? cteSeguro; 

  CteSeguroGrouped({
		this.cteSeguro, 

  });
}
