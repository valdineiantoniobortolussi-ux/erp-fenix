import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		Produtos,
		NfeReferenciadas,
		NfeEmitentes,
		NfeDestinatarios,
		NfeLocalRetiradas,
		NfeLocalEntregas,
		NfeDetEspecificoVeiculos,
		NfeDetEspecificoMedicamentos,
		NfeDetEspecificoArmamentos,
		NfeDetEspecificoCombustivels,
		NfeTransportes,
		NfeFaturas,
		NfeDeclaracaoImportacaos,
		NfeCanas,
		NfeCupomFiscalReferenciados,
		NfeProdRuralReferenciadas,
		NfeNfReferenciadas,
		NfeDetalheImpostoIcmss,
		NfeDetalheImpostoIpis,
		NfeDetalheImpostoIis,
		NfeDetalheImpostoPiss,
		NfeDetalheImpostoCofinss,
		NfeDetalheImpostoIssqns,
		NfeProcessoReferenciados,
		NfeCteReferenciados,
		NfeAcessoXmls,
		NfeExportacaos,
		NfeInformacaoPagamentos,
		NfeItemRastreados,
		NfeDetalheImpostoPisSts,
		NfeDetalheImpostoIcmsUfdests,
		NfeDetalheImpostoCofinsSts,
		NfeResponsavelTecnicos,
		ProdutoGrupos,
		ProdutoSubgrupos,
		ProdutoMarcas,
		ProdutoUnidades,
		NfeCabecalhos,
		NfeDetalhes,
		TributOperacaoFiscals,
		VendaCabecalhos,
		NfeDuplicatas,
		NfeImportacaoDetalhes,
		NfeCanaFornecimentoDiarios,
		NfeCanaDeducoesSafras,
		NfeNumeros,
		NfeTransporteReboques,
		NfeTransporteVolumes,
		NfeTransporteVolumeLacres,
		NfeConfiguracaos,
		NfeNumeroInutilizados,
		ViewControleAcessos,
		ViewPessoaUsuarios,
		ViewPessoaClientes,
		ViewPessoaFornecedors,
		ViewPessoaColaboradors,
		ViewPessoaVendedors,
		ViewPessoaTransportadoras,
 ], 
	daos: [
		ProdutoGrupoDao,
		ProdutoSubgrupoDao,
		ProdutoMarcaDao,
		ProdutoUnidadeDao,
		NfeCabecalhoDao,
		NfeDetalheDao,
		TributOperacaoFiscalDao,
		VendaCabecalhoDao,
		NfeDuplicataDao,
		NfeImportacaoDetalheDao,
		NfeCanaFornecimentoDiarioDao,
		NfeCanaDeducoesSafraDao,
		NfeNumeroDao,
		NfeTransporteReboqueDao,
		NfeTransporteVolumeDao,
		NfeTransporteVolumeLacreDao,
		NfeConfiguracaoDao,
		NfeNumeroInutilizadoDao,
		ViewControleAcessoDao,
		ViewPessoaUsuarioDao,
		ViewPessoaClienteDao,
		ViewPessoaFornecedorDao,
		ViewPessoaColaboradorDao,
		ViewPessoaVendedorDao,
		ViewPessoaTransportadoraDao,
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
