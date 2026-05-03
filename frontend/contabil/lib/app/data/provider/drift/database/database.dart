import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		ContabilLancamentoDetalhes,
		ContabilDreDetalhes,
		ContabilTermos,
		ContabilEncerramentoExeDets,
		RateioCentroResultadoDets,
		ContabilIndiceValors,
		CtResultadoNtFinanceiras,
		ContabilLancamentoCabecalhos,
		ContabilDreCabecalhos,
		ContabilLivros,
		ContabilEncerramentoExeCabs,
		CentroResultados,
		RateioCentroResultadoCabs,
		ContabilIndices,
		FinNaturezaFinanceiras,
		AidfAimdfs,
		Faps,
		RegistroCartorios,
		ContabilParametros,
		PlanoContaRefSpeds,
		PlanoContas,
		ContabilContas,
		ContabilHistoricos,
		ContabilLancamentoPadraos,
		ContabilLotes,
		ContabilLancamentoOrcados,
		LancaCentroResultados,
		EncerraCentroResultados,
		ContabilContaRateios,
		ContabilFechamentos,
		ViewControleAcessos,
		ViewPessoaUsuarios,
		PlanoCentroResultados,
 ], 
	daos: [
		ContabilLancamentoCabecalhoDao,
		ContabilDreCabecalhoDao,
		ContabilLivroDao,
		ContabilEncerramentoExeCabDao,
		CentroResultadoDao,
		RateioCentroResultadoCabDao,
		ContabilIndiceDao,
		FinNaturezaFinanceiraDao,
		AidfAimdfDao,
		FapDao,
		RegistroCartorioDao,
		ContabilParametroDao,
		PlanoContaRefSpedDao,
		PlanoContaDao,
		ContabilContaDao,
		ContabilHistoricoDao,
		ContabilLancamentoPadraoDao,
		ContabilLoteDao,
		ContabilLancamentoOrcadoDao,
		LancaCentroResultadoDao,
		EncerraCentroResultadoDao,
		ContabilContaRateioDao,
		ContabilFechamentoDao,
		ViewControleAcessoDao,
		ViewPessoaUsuarioDao,
		PlanoCentroResultadoDao,
	],
)

class AppDatabase extends _$AppDatabase {
	AppDatabase(QueryExecutor executor) : super(executor);

	@override
	int get schemaVersion => 1;

	@override
	MigrationStrategy get migration => MigrationStrategy(
		onCreate: (Migrator m) async {
			await m.createAll();
			await _populateDatabase(this);
		},		
	);	
}

Future<void> _populateDatabase(db) async {
	await db.customStatement("CREATE TABLE HIDDEN_SETTINGS("
				"ID INTEGER PRIMARY KEY,"
				"APP_THEME TEXT"
			")");
	await db.customStatement("INSERT INTO HIDDEN_SETTINGS (ID, APP_THEME) VALUES (1, 'ThemeMode.light')");
}
