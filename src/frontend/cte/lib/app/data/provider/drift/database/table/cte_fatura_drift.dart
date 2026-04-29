import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteFatura")
class CteFaturas extends Table {
	@override
	String get tableName => 'cte_fatura';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 60).nullable()();
	RealColumn get valorOriginal => real().named('valor_original').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorLiquido => real().named('valor_liquido').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteFaturaGrouped {
	CteFatura? cteFatura; 

  CteFaturaGrouped({
		this.cteFatura, 

  });
}
