import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteInformacaoNfTransporte")
class CteInformacaoNfTransportes extends Table {
	@override
	String get tableName => 'cte_informacao_nf_transporte';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteInformacaoNf => integer().named('id_cte_informacao_nf').nullable()();
	TextColumn get tipoUnidadeTransporte => text().named('tipo_unidade_transporte').withLength(min: 0, max: 1).nullable()();
	TextColumn get idUnidadeTransporte => text().named('id_unidade_transporte').withLength(min: 0, max: 20).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteInformacaoNfTransporteGrouped {
	CteInformacaoNfTransporte? cteInformacaoNfTransporte; 
	CteInformacaoNfOutros? cteInformacaoNfOutros; 

  CteInformacaoNfTransporteGrouped({
		this.cteInformacaoNfTransporte, 
		this.cteInformacaoNfOutros, 

  });
}
