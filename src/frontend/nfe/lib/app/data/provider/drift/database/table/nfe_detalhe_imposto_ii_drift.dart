import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoIi")
class NfeDetalheImpostoIis extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_ii';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	RealColumn get valorBcIi => real().named('valor_bc_ii').nullable()();
	RealColumn get valorDespesasAduaneiras => real().named('valor_despesas_aduaneiras').nullable()();
	RealColumn get valorImpostoImportacao => real().named('valor_imposto_importacao').nullable()();
	RealColumn get valorIof => real().named('valor_iof').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoIiGrouped {
	NfeDetalheImpostoIi? nfeDetalheImpostoIi; 

  NfeDetalheImpostoIiGrouped({
		this.nfeDetalheImpostoIi, 

  });
}
