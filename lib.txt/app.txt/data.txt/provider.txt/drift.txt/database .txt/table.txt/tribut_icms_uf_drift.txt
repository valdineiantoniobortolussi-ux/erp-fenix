import 'package:drift/drift.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';

@DataClassName("TributIcmsUf")
class TributIcmsUfs extends Table {
	@override
	String get tableName => 'tribut_icms_uf';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idTributConfiguraOfGt => integer().named('id_tribut_configura_of_gt').nullable()();
	TextColumn get ufDestino => text().named('uf_destino').withLength(min: 0, max: 2).nullable()();
	TextColumn get cst => text().named('cst').withLength(min: 0, max: 2).nullable()();
	TextColumn get csosn => text().named('csosn').withLength(min: 0, max: 3).nullable()();
	TextColumn get modalidadeBc => text().named('modalidade_bc').withLength(min: 0, max: 1).nullable()();
	IntColumn get cfop => integer().named('cfop').nullable()();
	RealColumn get aliquota => real().named('aliquota').nullable()();
	RealColumn get valorPauta => real().named('valor_pauta').nullable()();
	RealColumn get valorPrecoMaximo => real().named('valor_preco_maximo').nullable()();
	RealColumn get mva => real().named('mva').nullable()();
	RealColumn get porcentoBc => real().named('porcento_bc').nullable()();
	TextColumn get modalidadeBcSt => text().named('modalidade_bc_st').withLength(min: 0, max: 1).nullable()();
	RealColumn get aliquotaInternaSt => real().named('aliquota_interna_st').nullable()();
	RealColumn get aliquotaInterestadualSt => real().named('aliquota_interestadual_st').nullable()();
	RealColumn get porcentoBcSt => real().named('porcento_bc_st').nullable()();
	RealColumn get aliquotaIcmsSt => real().named('aliquota_icms_st').nullable()();
	RealColumn get valorPautaSt => real().named('valor_pauta_st').nullable()();
	RealColumn get valorPrecoMaximoSt => real().named('valor_preco_maximo_st').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TributIcmsUfGrouped {
	TributIcmsUf? tributIcmsUf; 

  TributIcmsUfGrouped({
		this.tributIcmsUf, 

  });
}
