import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		PatrimDocumentoBems,
		PatrimDepreciacaoBems,
		PatrimMovimentacaoBems,
		PatrimApoliceSeguros,
		PatrimBems,
		Setors,
		CentroResultados,
		PatrimIndiceAtualizacaos,
		PatrimTaxaDepreciacaos,
		PatrimGrupoBems,
		PatrimTipoAquisicaoBems,
		PatrimEstadoConservacaos,
		Seguradoras,
		PatrimTipoMovimentacaos,
		ViewControleAcessos,
		ViewPessoaUsuarios,
		ViewPessoaFornecedors,
		ViewPessoaColaboradors,
 ], 
	daos: [
		PatrimBemDao,
		SetorDao,
		CentroResultadoDao,
		PatrimIndiceAtualizacaoDao,
		PatrimTaxaDepreciacaoDao,
		PatrimGrupoBemDao,
		PatrimTipoAquisicaoBemDao,
		PatrimEstadoConservacaoDao,
		SeguradoraDao,
		PatrimTipoMovimentacaoDao,
		ViewControleAcessoDao,
		ViewPessoaUsuarioDao,
		ViewPessoaFornecedorDao,
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
