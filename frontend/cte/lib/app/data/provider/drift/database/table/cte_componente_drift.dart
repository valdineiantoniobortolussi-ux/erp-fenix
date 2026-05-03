import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteComponente")
class CteComponentes extends Table {
	@override
	String get tableName => 'cte_componente';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 15).nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteComponenteGrouped {
	CteComponente? cteComponente; 

  CteComponenteGrouped({
		this.cteComponente, 

  });
}
