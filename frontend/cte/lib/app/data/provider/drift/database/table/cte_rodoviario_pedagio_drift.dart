import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteRodoviarioPedagio")
class CteRodoviarioPedagios extends Table {
	@override
	String get tableName => 'cte_rodoviario_pedagio';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteRodoviario => integer().named('id_cte_rodoviario').nullable()();
	TextColumn get cnpjFornecedor => text().named('cnpj_fornecedor').withLength(min: 0, max: 14).nullable()();
	TextColumn get comprovanteCompra => text().named('comprovante_compra').withLength(min: 0, max: 20).nullable()();
	TextColumn get cnpjResponsavel => text().named('cnpj_responsavel').withLength(min: 0, max: 14).nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteRodoviarioPedagioGrouped {
	CteRodoviarioPedagio? cteRodoviarioPedagio; 
	CteRodoviario? cteRodoviario; 

  CteRodoviarioPedagioGrouped({
		this.cteRodoviarioPedagio, 
		this.cteRodoviario, 

  });
}
