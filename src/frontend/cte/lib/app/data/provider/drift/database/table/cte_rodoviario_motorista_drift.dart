import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteRodoviarioMotorista")
class CteRodoviarioMotoristas extends Table {
	@override
	String get tableName => 'cte_rodoviario_motorista';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteRodoviario => integer().named('id_cte_rodoviario').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 60).nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteRodoviarioMotoristaGrouped {
	CteRodoviarioMotorista? cteRodoviarioMotorista; 
	CteRodoviario? cteRodoviario; 

  CteRodoviarioMotoristaGrouped({
		this.cteRodoviarioMotorista, 
		this.cteRodoviario, 

  });
}
