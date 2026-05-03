import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoCofinsSt")
class NfeDetalheImpostoCofinsSts extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_cofins_st';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	RealColumn get baseCalculoCofinsSt => real().named('base_calculo_cofins_st').nullable()();
	RealColumn get aliquotaCofinsStPercentual => real().named('aliquota_cofins_st_percentual').nullable()();
	RealColumn get quantidadeVendidaCofinsSt => real().named('quantidade_vendida_cofins_st').nullable()();
	RealColumn get aliquotaCofinsStReais => real().named('aliquota_cofins_st_reais').nullable()();
	RealColumn get valorCofinsSt => real().named('valor_cofins_st').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoCofinsStGrouped {
	NfeDetalheImpostoCofinsSt? nfeDetalheImpostoCofinsSt; 

  NfeDetalheImpostoCofinsStGrouped({
		this.nfeDetalheImpostoCofinsSt, 

  });
}
