import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteInfNfTransporteLacre")
class CteInfNfTransporteLacres extends Table {
	@override
	String get tableName => 'cte_inf_nf_transporte_lacre';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteInformacaoNfTransporte => integer().named('id_cte_informacao_nf_transporte').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteInfNfTransporteLacreGrouped {
	CteInfNfTransporteLacre? cteInfNfTransporteLacre; 
	CteInformacaoNfTransporte? cteInformacaoNfTransporte; 

  CteInfNfTransporteLacreGrouped({
		this.cteInfNfTransporteLacre, 
		this.cteInformacaoNfTransporte, 

  });
}
