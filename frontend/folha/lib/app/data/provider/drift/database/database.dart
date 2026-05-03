import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		EmpresaTransporteItinerarios,
		FolhaLancamentoDetalhes,
		FolhaInssRetencaos,
		FolhaPppCats,
		FolhaPppAtividades,
		FolhaPppFatorRiscos,
		FolhaPppExameMedicos,
		EmpresaTransportes,
		FolhaLancamentoCabecalhos,
		FolhaInsss,
		FolhaPpps,
		OperadoraPlanoSaudes,
		FolhaLancamentoComissaos,
		FolhaParametros,
		GuiasAcumuladass,
		FolhaFechamentos,
		FeriasPeriodoAquisitivos,
		FolhaTipoAfastamentos,
		FolhaAfastamentos,
		FolhaPlanoSaudes,
		FolhaEventos,
		FolhaRescisaos,
		FolhaFeriasColetivass,
		FolhaValeTransportes,
		FolhaInssServicos,
		FolhaHistoricoSalarials,
		Feriadoss,
		ViewControleAcessos,
		ViewPessoaUsuarios,
		ViewPessoaColaboradors,
 ], 
	daos: [
		EmpresaTransporteDao,
		FolhaLancamentoCabecalhoDao,
		FolhaInssDao,
		FolhaPppDao,
		OperadoraPlanoSaudeDao,
		FolhaLancamentoComissaoDao,
		FolhaParametroDao,
		GuiasAcumuladasDao,
		FolhaFechamentoDao,
		FeriasPeriodoAquisitivoDao,
		FolhaTipoAfastamentoDao,
		FolhaAfastamentoDao,
		FolhaPlanoSaudeDao,
		FolhaEventoDao,
		FolhaRescisaoDao,
		FolhaFeriasColetivasDao,
		FolhaValeTransporteDao,
		FolhaInssServicoDao,
		FolhaHistoricoSalarialDao,
		FeriadosDao,
		ViewControleAcessoDao,
		ViewPessoaUsuarioDao,
		ViewPessoaColaboradorDao,
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
