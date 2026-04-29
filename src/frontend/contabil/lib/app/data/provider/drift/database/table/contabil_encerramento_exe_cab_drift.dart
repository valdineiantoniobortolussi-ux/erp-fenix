import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

@DataClassName("ContabilEncerramentoExeCab")
class ContabilEncerramentoExeCabs extends Table {
	@override
	String get tableName => 'contabil_encerramento_exe_cab';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	DateTimeColumn get dataInclusao => dateTime().named('data_inclusao').nullable()();
	TextColumn get motivo => text().named('motivo').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilEncerramentoExeCabGrouped {
	ContabilEncerramentoExeCab? contabilEncerramentoExeCab; 
	List<ContabilEncerramentoExeDetGrouped>? contabilEncerramentoExeDetGroupedList; 

  ContabilEncerramentoExeCabGrouped({
		this.contabilEncerramentoExeCab, 
		this.contabilEncerramentoExeDetGroupedList, 

  });
}
