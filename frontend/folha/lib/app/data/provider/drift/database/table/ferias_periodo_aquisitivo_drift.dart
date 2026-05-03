import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FeriasPeriodoAquisitivo")
class FeriasPeriodoAquisitivos extends Table {
	@override
	String get tableName => 'ferias_periodo_aquisitivo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	TextColumn get situacao => text().named('situacao').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get limiteParaGozo => dateTime().named('limite_para_gozo').nullable()();
	TextColumn get descontarFaltas => text().named('descontar_faltas').withLength(min: 0, max: 1).nullable()();
	TextColumn get desconsiderarAfastamento => text().named('desconsiderar_afastamento').withLength(min: 0, max: 1).nullable()();
	IntColumn get afastamentoPrevidencia => integer().named('afastamento_previdencia').nullable()();
	IntColumn get afastamentoSemRemun => integer().named('afastamento_sem_remun').nullable()();
	IntColumn get afastamentoComRemun => integer().named('afastamento_com_remun').nullable()();
	IntColumn get diasDireito => integer().named('dias_direito').nullable()();
	IntColumn get diasGozados => integer().named('dias_gozados').nullable()();
	IntColumn get diasFaltas => integer().named('dias_faltas').nullable()();
	IntColumn get diasRestantes => integer().named('dias_restantes').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FeriasPeriodoAquisitivoGrouped {
	FeriasPeriodoAquisitivo? feriasPeriodoAquisitivo; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  FeriasPeriodoAquisitivoGrouped({
		this.feriasPeriodoAquisitivo, 
		this.viewPessoaColaborador, 

  });
}
