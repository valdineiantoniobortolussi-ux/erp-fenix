import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';

@DataClassName("ContratoPrevFaturamento")
class ContratoPrevFaturamentos extends Table {
	@override
	String get tableName => 'contrato_prev_faturamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContrato => integer().named('id_contrato').nullable()();
	DateTimeColumn get dataPrevista => dateTime().named('data_prevista').nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContratoPrevFaturamentoGrouped {
	ContratoPrevFaturamento? contratoPrevFaturamento; 

  ContratoPrevFaturamentoGrouped({
		this.contratoPrevFaturamento, 

  });
}
