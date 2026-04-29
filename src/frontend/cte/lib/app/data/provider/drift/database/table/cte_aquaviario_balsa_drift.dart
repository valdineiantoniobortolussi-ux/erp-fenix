import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteAquaviarioBalsa")
class CteAquaviarioBalsas extends Table {
	@override
	String get tableName => 'cte_aquaviario_balsa';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteAquaviario => integer().named('id_cte_aquaviario').nullable()();
	TextColumn get idBalsa => text().named('id_balsa').withLength(min: 0, max: 60).nullable()();
	IntColumn get numeroViagem => integer().named('numero_viagem').nullable()();
	TextColumn get direcao => text().named('direcao').withLength(min: 0, max: 1).nullable()();
	TextColumn get portoEmbarque => text().named('porto_embarque').withLength(min: 0, max: 60).nullable()();
	TextColumn get portoTransbordo => text().named('porto_transbordo').withLength(min: 0, max: 60).nullable()();
	TextColumn get portoDestino => text().named('porto_destino').withLength(min: 0, max: 60).nullable()();
	TextColumn get tipoNavegacao => text().named('tipo_navegacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get irin => text().named('irin').withLength(min: 0, max: 10).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteAquaviarioBalsaGrouped {
	CteAquaviarioBalsa? cteAquaviarioBalsa; 
	CteAquaviario? cteAquaviario; 

  CteAquaviarioBalsaGrouped({
		this.cteAquaviarioBalsa, 
		this.cteAquaviario, 

  });
}
