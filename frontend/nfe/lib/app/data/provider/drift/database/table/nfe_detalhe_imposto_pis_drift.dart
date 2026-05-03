import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoPis")
class NfeDetalheImpostoPiss extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_pis';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get cstPis => text().named('cst_pis').withLength(min: 0, max: 2).nullable()();
	RealColumn get valorBaseCalculoPis => real().named('valor_base_calculo_pis').nullable()();
	RealColumn get aliquotaPisPercentual => real().named('aliquota_pis_percentual').nullable()();
	RealColumn get valorPis => real().named('valor_pis').nullable()();
	RealColumn get quantidadeVendida => real().named('quantidade_vendida').nullable()();
	RealColumn get aliquotaPisReais => real().named('aliquota_pis_reais').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoPisGrouped {
	NfeDetalheImpostoPis? nfeDetalheImpostoPis; 

  NfeDetalheImpostoPisGrouped({
		this.nfeDetalheImpostoPis, 

  });
}
