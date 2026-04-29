import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteInformacaoNfCarga")
class CteInformacaoNfCargas extends Table {
	@override
	String get tableName => 'cte_informacao_nf_carga';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteInformacaoNf => integer().named('id_cte_informacao_nf').nullable()();
	TextColumn get tipoUnidadeCarga => text().named('tipo_unidade_carga').withLength(min: 0, max: 1).nullable()();
	TextColumn get idUnidadeCarga => text().named('id_unidade_carga').withLength(min: 0, max: 20).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteInformacaoNfCargaGrouped {
	CteInformacaoNfCarga? cteInformacaoNfCarga; 
	CteInformacaoNfOutros? cteInformacaoNfOutros; 

  CteInformacaoNfCargaGrouped({
		this.cteInformacaoNfCarga, 
		this.cteInformacaoNfOutros, 

  });
}
