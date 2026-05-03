import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaPppExameMedico")
class FolhaPppExameMedicos extends Table {
	@override
	String get tableName => 'folha_ppp_exame_medico';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFolhaPpp => integer().named('id_folha_ppp').nullable()();
	DateTimeColumn get dataUltimo => dateTime().named('data_ultimo').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get exame => text().named('exame').withLength(min: 0, max: 1).nullable()();
	TextColumn get natureza => text().named('natureza').withLength(min: 0, max: 50).nullable()();
	TextColumn get indicacaoResultados => text().named('indicacao_resultados').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaPppExameMedicoGrouped {
	FolhaPppExameMedico? folhaPppExameMedico; 

  FolhaPppExameMedicoGrouped({
		this.folhaPppExameMedico, 

  });
}
