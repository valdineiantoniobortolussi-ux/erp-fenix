import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		RequisicaoInternaDetalhes,
		EstoqueReajusteDetalhes,
		RequisicaoInternaCabecalhos,
		EstoqueReajusteCabecalhos,
		ProdutoGrupos,
		ProdutoSubgrupos,
		ProdutoMarcas,
		ProdutoUnidades,
		Produtos,
		EstoqueCors,
		EstoqueTamanhos,
		EstoqueSabors,
		EstoqueMarcas,
		EstoqueGrades,
		ViewControleAcessos,
		ViewPessoaUsuarios,
		ViewPessoaColaboradors,
 ], 
	daos: [
		RequisicaoInternaCabecalhoDao,
		EstoqueReajusteCabecalhoDao,
		ProdutoGrupoDao,
		ProdutoSubgrupoDao,
		ProdutoMarcaDao,
		ProdutoUnidadeDao,
		ProdutoDao,
		EstoqueCorDao,
		EstoqueTamanhoDao,
		EstoqueSaborDao,
		EstoqueMarcaDao,
		EstoqueGradeDao,
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
