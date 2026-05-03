import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteDutoviario")
class CteDutoviarios extends Table {
	@override
	String get tableName => 'cte_dutoviario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	RealColumn get valorTarifa => real().named('valor_tarifa').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteDutoviarioGrouped {
	CteDutoviario? cteDutoviario; 

  CteDutoviarioGrouped({
		this.cteDutoviario, 

  });
}
