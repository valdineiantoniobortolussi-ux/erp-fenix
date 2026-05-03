import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilIndiceValor")
class ContabilIndiceValors extends Table {
	@override
	String get tableName => 'contabil_indice_valor';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContabilIndice => integer().named('id_contabil_indice').nullable()();
	DateTimeColumn get dataIndice => dateTime().named('data_indice').nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilIndiceValorGrouped {
	ContabilIndiceValor? contabilIndiceValor; 

  ContabilIndiceValorGrouped({
		this.contabilIndiceValor, 

  });
}
