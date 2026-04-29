import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteRodoviarioOcc")
class CteRodoviarioOccs extends Table {
	@override
	String get tableName => 'cte_rodoviario_occ';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteRodoviario => integer().named('id_cte_rodoviario').nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	IntColumn get numero => integer().named('numero').nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get codigoInterno => text().named('codigo_interno').withLength(min: 0, max: 10).nullable()();
	TextColumn get ie => text().named('ie').withLength(min: 0, max: 14).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get telefone => text().named('telefone').withLength(min: 0, max: 14).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteRodoviarioOccGrouped {
	CteRodoviarioOcc? cteRodoviarioOcc; 
	CteRodoviario? cteRodoviario; 

  CteRodoviarioOccGrouped({
		this.cteRodoviarioOcc, 
		this.cteRodoviario, 

  });
}
