import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_cana_fornecimento_diario_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_cana_fornecimento_diario_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_cana_fornecimento_diario_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_cana_fornecimento_diario_repository.dart';

class NfeCanaFornecimentoDiarioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeCanaFornecimentoDiarioController>(() => NfeCanaFornecimentoDiarioController(
					nfeCanaFornecimentoDiarioRepository:
							NfeCanaFornecimentoDiarioRepository(nfeCanaFornecimentoDiarioApiProvider: NfeCanaFornecimentoDiarioApiProvider(), nfeCanaFornecimentoDiarioDriftProvider: NfeCanaFornecimentoDiarioDriftProvider()))),
		];
	}
}
