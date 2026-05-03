import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_configuracao_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_configuracao_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_configuracao_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_configuracao_repository.dart';

class NfeConfiguracaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeConfiguracaoController>(() => NfeConfiguracaoController(
					nfeConfiguracaoRepository:
							NfeConfiguracaoRepository(nfeConfiguracaoApiProvider: NfeConfiguracaoApiProvider(), nfeConfiguracaoDriftProvider: NfeConfiguracaoDriftProvider()))),
		];
	}
}
