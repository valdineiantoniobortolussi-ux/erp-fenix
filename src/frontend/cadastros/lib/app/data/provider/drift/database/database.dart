import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		PessoaFisicas,
		PessoaJuridicas,
		Clientes,
		Fornecedors,
		Transportadoras,
		Contadors,
		Vendedors,
		PessoaEnderecos,
		PessoaContatos,
		PessoaTelefones,
		ColaboradorRelacionamentos,
		PapelFuncaos,
		Usuarios,
		Pessoas,
		Colaboradors,
		Papels,
		Funcaos,
		EstadoCivils,
		Cargos,
		Setors,
		ColaboradorSituacaos,
		TipoAdmissaos,
		ColaboradorTipos,
		ProdutoGrupos,
		ProdutoSubgrupos,
		ProdutoMarcas,
		ProdutoUnidades,
		Produtos,
		Bancos,
		BancoAgencias,
		BancoContaCaixas,
		Ceps,
		Ufs,
		Municipios,
		Ncms,
		Cfops,
		CstIcmss,
		CstIpis,
		CstCofinss,
		CstPiss,
		Csosns,
		Cnaes,
		Paiss,
		NivelFormacaos,
		TabelaPrecos,
		TipoRelacionamentos,
		ViewControleAcessos,
		ViewPessoaUsuarios,
		ComissaoPerfils,
		Sindicatos,
		TributIcmsCustomCabs,
		TributGrupoTributarios,
 ], 
	daos: [
		PessoaDao,
		ColaboradorDao,
		PapelDao,
		FuncaoDao,
		EstadoCivilDao,
		CargoDao,
		SetorDao,
		ColaboradorSituacaoDao,
		TipoAdmissaoDao,
		ColaboradorTipoDao,
		ProdutoGrupoDao,
		ProdutoSubgrupoDao,
		ProdutoMarcaDao,
		ProdutoUnidadeDao,
		ProdutoDao,
		BancoDao,
		BancoAgenciaDao,
		BancoContaCaixaDao,
		CepDao,
		UfDao,
		MunicipioDao,
		NcmDao,
		CfopDao,
		CstIcmsDao,
		CstIpiDao,
		CstCofinsDao,
		CstPisDao,
		CsosnDao,
		CnaeDao,
		PaisDao,
		NivelFormacaoDao,
		TabelaPrecoDao,
		TipoRelacionamentoDao,
		ViewControleAcessoDao,
		ViewPessoaUsuarioDao,
		ComissaoPerfilDao,
		SindicatoDao,
		TributIcmsCustomCabDao,
		TributGrupoTributarioDao,
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
