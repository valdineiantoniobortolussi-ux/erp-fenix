import 'package:get/get.dart';
import 'package:nfse/app/controller/nfse_cabecalho_controller.dart';
import 'package:nfse/app/data/provider/api/nfse_cabecalho_api_provider.dart';
import 'package:nfse/app/data/provider/drift/nfse_cabecalho_drift_provider.dart';
import 'package:nfse/app/data/repository/nfse_cabecalho_repository.dart';

class NfseCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfseCabecalhoController>(() => NfseCabecalhoController(
					nfseCabecalhoRepository:
							NfseCabecalhoRepository(nfseCabecalhoApiProvider: NfseCabecalhoApiProvider(), nfseCabecalhoDriftProvider: NfseCabecalhoDriftProvider()))),
		];
	}
}
