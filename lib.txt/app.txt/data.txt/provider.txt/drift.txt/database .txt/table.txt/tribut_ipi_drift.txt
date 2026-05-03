import 'package:drift/drift.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';

@DataClassName("TributIpi")
class TributIpis extends Table {
	@override
	String get tableName => 'tribut_ipi';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idTributConfiguraOfGt => integer().named('id_tribut_configura_of_gt').nullable()();
	TextColumn get cstIpi => text().named('cst_ipi').withLength(min: 0, max: 2).nullable()();
	TextColumn get modalidadeBaseCalculo => text().named('modalidade_base_calculo').withLength(min: 0, max: 1).nullable()();
	RealColumn get porcentoBaseCalculo => real().named('porcento_base_calculo').nullable()();
	RealColumn get aliquotaPorcento => real().named('aliquota_porcento').nullable()();
	RealColumn get aliquotaUnidade => real().named('aliquota_unidade').nullable()();
	RealColumn get valorPrecoMaximo => real().named('valor_preco_maximo').nullable()();
	RealColumn get valorPautaFiscal => real().named('valor_pauta_fiscal').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TributIpiGrouped {
	TributIpi? tributIpi; 

  TributIpiGrouped({
		this.tributIpi, 

  });
}
