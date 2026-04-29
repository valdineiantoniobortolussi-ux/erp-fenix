import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		Cheques,
		FinParcelaPagars,
		FinParcelaRecebers,
		TalonarioCheques,
		FinLancamentoPagars,
		FinLancamentoRecebers,
		Bancos,
		BancoAgencias,
		BancoContaCaixas,
		FinFechamentoCaixaBancos,
		FinExtratoContaBancos,
		FinDocumentoOrigems,
		FinNaturezaFinanceiras,
		FinStatusParcelas,
		FinTipoPagamentos,
		FinChequeEmitidos,
		FinTipoRecebimentos,
		FinChequeRecebidos,
		FinConfiguracaoBoletos,
		ViewControleAcessos,
		ViewPessoaUsuarios,
		ViewPessoaClientes,
		ViewPessoaFornecedors,
 ], 
	daos: [
		TalonarioChequeDao,
		FinLancamentoPagarDao,
		FinLancamentoReceberDao,
		BancoDao,
		BancoAgenciaDao,
		BancoContaCaixaDao,
		FinFechamentoCaixaBancoDao,
		FinExtratoContaBancoDao,
		FinDocumentoOrigemDao,
		FinNaturezaFinanceiraDao,
		FinStatusParcelaDao,
		FinTipoPagamentoDao,
		FinChequeEmitidoDao,
		FinTipoRecebimentoDao,
		FinChequeRecebidoDao,
		FinConfiguracaoBoletoDao,
		ViewControleAcessoDao,
		ViewPessoaUsuarioDao,
		ViewPessoaClienteDao,
		ViewPessoaFornecedorDao,
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
