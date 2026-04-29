import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteMultimodal")
class CteMultimodals extends Table {
	@override
	String get tableName => 'cte_multimodal';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get cotm => text().named('cotm').withLength(min: 0, max: 20).nullable()();
	TextColumn get indicadorNegociavel => text().named('indicador_negociavel').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteMultimodalGrouped {
	CteMultimodal? cteMultimodal; 

  CteMultimodalGrouped({
		this.cteMultimodal, 

  });
}
