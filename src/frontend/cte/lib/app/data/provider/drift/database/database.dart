import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		CteEmitentes,
		CteLocalColetas,
		CteTomadors,
		CtePassagems,
		CteRemetentes,
		CteExpedidors,
		CteRecebedors,
		CteDestinatarios,
		CteLocalEntregas,
		CteComponentes,
		CteCargas,
		CteInformacaoNfOutross,
		CteSeguros,
		CtePerigosos,
		CteVeiculoNovos,
		CteFaturas,
		CteDuplicatas,
		CteRodoviarios,
		CteAereos,
		CteAquaviarios,
		CteFerroviarios,
		CteDutoviarios,
		CteMultimodals,
		CteCabecalhos,
		CteInformacaoNfTransportes,
		CteInfNfTransporteLacres,
		CteInformacaoNfCargas,
		CteInfNfCargaLacres,
		CteDocumentoAnteriorIds,
		CteRodoviarioOccs,
		CteRodoviarioPedagios,
		CteRodoviarioVeiculos,
		CteRodoviarioLacres,
		CteRodoviarioMotoristas,
		CteAquaviarioBalsas,
		CteFerroviarioFerrovias,
		CteFerroviarioVagaos,
		ViewControleAcessos,
		ViewPessoaUsuarios,
 ], 
	daos: [
		CteCabecalhoDao,
		CteInformacaoNfTransporteDao,
		CteInfNfTransporteLacreDao,
		CteInformacaoNfCargaDao,
		CteInfNfCargaLacreDao,
		CteDocumentoAnteriorIdDao,
		CteRodoviarioOccDao,
		CteRodoviarioPedagioDao,
		CteRodoviarioVeiculoDao,
		CteRodoviarioLacreDao,
		CteRodoviarioMotoristaDao,
		CteAquaviarioBalsaDao,
		CteFerroviarioFerroviaDao,
		CteFerroviarioVagaoDao,
		ViewControleAcessoDao,
		ViewPessoaUsuarioDao,
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
