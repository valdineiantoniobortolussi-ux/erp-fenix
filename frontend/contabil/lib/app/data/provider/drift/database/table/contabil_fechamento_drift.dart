import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilFechamento")
class ContabilFechamentos extends Table {
	@override
	String get tableName => 'contabil_fechamento';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	TextColumn get criterioLancamento => text().named('criterio_lancamento').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilFechamentoGrouped {
	ContabilFechamento? contabilFechamento; 

  ContabilFechamentoGrouped({
		this.contabilFechamento, 

  });
}
