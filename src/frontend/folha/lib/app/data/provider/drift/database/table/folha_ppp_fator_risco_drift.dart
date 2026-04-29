import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaPppFatorRisco")
class FolhaPppFatorRiscos extends Table {
	@override
	String get tableName => 'folha_ppp_fator_risco';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFolhaPpp => integer().named('id_folha_ppp').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get fatorRisco => text().named('fator_risco').withLength(min: 0, max: 40).nullable()();
	TextColumn get intensidade => text().named('intensidade').withLength(min: 0, max: 15).nullable()();
	TextColumn get tecnicaUtilizada => text().named('tecnica_utilizada').withLength(min: 0, max: 40).nullable()();
	TextColumn get epcEficaz => text().named('epc_eficaz').withLength(min: 0, max: 1).nullable()();
	TextColumn get epiEficaz => text().named('epi_eficaz').withLength(min: 0, max: 1).nullable()();
	IntColumn get caEpi => integer().named('ca_epi').nullable()();
	TextColumn get atendimentoNr061 => text().named('atendimento_nr06_1').withLength(min: 0, max: 1).nullable()();
	TextColumn get atendimentoNr062 => text().named('atendimento_nr06_2').withLength(min: 0, max: 1).nullable()();
	TextColumn get atendimentoNr063 => text().named('atendimento_nr06_3').withLength(min: 0, max: 1).nullable()();
	TextColumn get atendimentoNr064 => text().named('atendimento_nr06_4').withLength(min: 0, max: 1).nullable()();
	TextColumn get atendimentoNr065 => text().named('atendimento_nr06_5').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaPppFatorRiscoGrouped {
	FolhaPppFatorRisco? folhaPppFatorRisco; 

  FolhaPppFatorRiscoGrouped({
		this.folhaPppFatorRisco, 

  });
}
