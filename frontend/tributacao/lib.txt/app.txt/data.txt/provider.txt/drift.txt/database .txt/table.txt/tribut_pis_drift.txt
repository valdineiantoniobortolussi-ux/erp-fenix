import 'package:drift/drift.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';

@DataClassName("TributPis")
class TributPiss extends Table {
	@override
	String get tableName => 'tribut_pis';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idTributConfiguraOfGt => integer().named('id_tribut_configura_of_gt').nullable()();
	TextColumn get cstPis => text().named('cst_pis').withLength(min: 0, max: 2).nullable()();
	TextColumn get modalidadeBaseCalculo => text().named('modalidade_base_calculo').withLength(min: 0, max: 1).nullable()();
	TextColumn get efdTabela435 => text().named('efd_tabela_435').withLength(min: 0, max: 2).nullable()();
	RealColumn get porcentoBaseCalculo => real().named('porcento_base_calculo').nullable()();
	RealColumn get aliquotaPorcento => real().named('aliquota_porcento').nullable()();
	RealColumn get aliquotaUnidade => real().named('aliquota_unidade').nullable()();
	RealColumn get valorPrecoMaximo => real().named('valor_preco_maximo').nullable()();
	RealColumn get valorPautaFiscal => real().named('valor_pauta_fiscal').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TributPisGrouped {
	TributPis? tributPis; 

  TributPisGrouped({
		this.tributPis, 

  });
}
