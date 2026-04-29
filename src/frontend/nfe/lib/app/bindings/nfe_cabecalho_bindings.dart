import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_cabecalho_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_cabecalho_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_cabecalho_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_cabecalho_repository.dart';

class NfeCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeCabecalhoController>(() => NfeCabecalhoController(
					nfeCabecalhoRepository:
							NfeCabecalhoRepository(nfeCabecalhoApiProvider: NfeCabecalhoApiProvider(), nfeCabecalhoDriftProvider: NfeCabecalhoDriftProvider()))),
		];
	}
}
