import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteInfNfCargaLacre")
class CteInfNfCargaLacres extends Table {
	@override
	String get tableName => 'cte_inf_nf_carga_lacre';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteInformacaoNfCarga => integer().named('id_cte_informacao_nf_carga').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();
	RealColumn get quantidadeRateada => real().named('quantidade_rateada').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteInfNfCargaLacreGrouped {
	CteInfNfCargaLacre? cteInfNfCargaLacre; 
	CteInformacaoNfCarga? cteInformacaoNfCarga; 

  CteInfNfCargaLacreGrouped({
		this.cteInfNfCargaLacre, 
		this.cteInformacaoNfCarga, 

  });
}
