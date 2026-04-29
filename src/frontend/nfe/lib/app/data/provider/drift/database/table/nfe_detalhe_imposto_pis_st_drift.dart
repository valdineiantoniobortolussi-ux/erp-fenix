import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoPisSt")
class NfeDetalheImpostoPisSts extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_pis_st';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	RealColumn get valorBaseCalculoPisSt => real().named('valor_base_calculo_pis_st').nullable()();
	RealColumn get aliquotaPisStPercentual => real().named('aliquota_pis_st_percentual').nullable()();
	RealColumn get quantidadeVendidaPisSt => real().named('quantidade_vendida_pis_st').nullable()();
	RealColumn get aliquotaPisStReais => real().named('aliquota_pis_st_reais').nullable()();
	RealColumn get valorPisSt => real().named('valor_pis_st').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoPisStGrouped {
	NfeDetalheImpostoPisSt? nfeDetalheImpostoPisSt; 

  NfeDetalheImpostoPisStGrouped({
		this.nfeDetalheImpostoPisSt, 

  });
}
