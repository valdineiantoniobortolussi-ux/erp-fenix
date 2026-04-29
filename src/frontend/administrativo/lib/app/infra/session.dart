import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/provider/api/lookup_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/lookup_drift_provider.dart';
import 'package:administrativo/app/data/repository/lookup_repository.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class Session {
	Session._();

	static String tokenJWT = '';
	static AppDatabase database = Get.find();

  static Map<String, List<String>> modulosBlocos = {};
  static Map<String, List<String>> modulosLinks = {};

	static bool waitDialogIsOpen = false;
  static List<ViewControleAcessoModel> accessControlList = [];
  static ViewPessoaUsuarioModel loggedInUser = ViewPessoaUsuarioModel();
  static EmpresaModel? empresaSessao = null;
  static bool testMode = false;

  /// Popula os módulos do ERP com seus links
  static void populateModules() {
    modulosBlocos = {
      'Comercial': ['Vendas', 'Compras', 'Orçamentos', 'NFC-e', 'NFS-e', 'CT-e', 'MDF-e', 'BP-e'],
      'Financeiro': ['Financeiro', 'Contábil', 'Comissões'],
      'Operacional': ['Estoque', 'WMS', 'Patrimônio', 'Frotas', 'PCP', 'Inventário'],
      'Fiscal': ['Fiscal', 'SPED', 'Tributação'],
      'Recursos Humanos': ['Folha', 'Ponto', 'eSocial'],
      'Administrativo': ['Cadastros', 'Contratos', 'GED', 'Agenda', 'Projetos', 'Ordem de Serviço'],
      'Outros': ['Gôndolas', 'Etiquetas'],
    };

    modulosLinks = {
      'Comercial': [
        'http://localhost:8081',
        'http://localhost:8082',
        'http://localhost:8023',
        'http://localhost:8021',
        'http://localhost:8022',
        'http://localhost:8009',
        'http://localhost:8020',
        'http://localhost:8003',
      ],
      'Financeiro': [
        'http://localhost:8083',
        'http://localhost:8080',
        'http://localhost:8005',
      ],
      'Operacional': [
        'http://localhost:8011',
        'http://localhost:8032',
        'http://localhost:8025',
        'http://localhost:8016',
        'http://localhost:8026',
        'http://localhost:8019',
      ],
      'Fiscal': [
        'http://localhost:8014',
        'http://localhost:8029',
        'http://localhost:8030',
      ],
      'Recursos Humanos': [
        'http://localhost:8015',
        'http://localhost:8027',
        'http://localhost:8010',
      ],
      'Administrativo': [
        'http://localhost:8084',
        'http://localhost:8008',
        'http://localhost:8017',
        'http://localhost:8002',
        'http://localhost:8028',
        'http://localhost:8024',
      ],
      'Outros': [
        'http://localhost:8018',
        'http://localhost:8012',
      ],
    };
  }

	/// populate main objects for the Session
	static Future populateMainObjects() async { 
		Get.lazyPut<LoginController>(() => LoginController());
		Get.lazyPut<FilterController>(() => FilterController(), permanent: true);
	 	Get.lazyPut<LookupController>(() => LookupController(lookupRepository: LookupRepository(lookupApiProvider: LookupApiProvider(), lookupDriftProvider: LookupDriftProvider())), permanent: true);
	}

	static setLookupController() {
		Get.lazyPut<LookupController>(() => LookupController(lookupRepository: LookupRepository(lookupApiProvider: LookupApiProvider(), lookupDriftProvider: LookupDriftProvider())));
	}
	
	static PlutoGridLocaleText getLocaleForPlutoGrid() {
		switch (Get.locale.toString()) {
			case 'pt_BR':
				return const PlutoGridLocaleText.brazilianPortuguese();
			case 'es_ES':
				return const PlutoGridLocaleText.spanish();
			default:
				return const PlutoGridLocaleText();
		}
	}

}