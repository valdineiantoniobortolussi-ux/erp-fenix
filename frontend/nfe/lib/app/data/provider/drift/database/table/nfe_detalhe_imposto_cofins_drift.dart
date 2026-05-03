import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoCofins")
class NfeDetalheImpostoCofinss extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_cofins';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get cstCofins => text().named('cst_cofins').withLength(min: 0, max: 2).nullable()();
	RealColumn get baseCalculoCofins => real().named('base_calculo_cofins').nullable()();
	RealColumn get aliquotaCofinsPercentual => real().named('aliquota_cofins_percentual').nullable()();
	RealColumn get quantidadeVendida => real().named('quantidade_vendida').nullable()();
	RealColumn get aliquotaCofinsReais => real().named('aliquota_cofins_reais').nullable()();
	RealColumn get valorCofins => real().named('valor_cofins').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoCofinsGrouped {
	NfeDetalheImpostoCofins? nfeDetalheImpostoCofins; 

  NfeDetalheImpostoCofinsGrouped({
		this.nfeDetalheImpostoCofins, 

  });
}
