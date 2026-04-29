import 'package:get/get.dart';
import 'package:nfse/app/controller/nfse_lista_servico_controller.dart';
import 'package:nfse/app/data/provider/api/nfse_lista_servico_api_provider.dart';
import 'package:nfse/app/data/provider/drift/nfse_lista_servico_drift_provider.dart';
import 'package:nfse/app/data/repository/nfse_lista_servico_repository.dart';

class NfseListaServicoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfseListaServicoController>(() => NfseListaServicoController(
					nfseListaServicoRepository:
							NfseListaServicoRepository(nfseListaServicoApiProvider: NfseListaServicoApiProvider(), nfseListaServicoDriftProvider: NfseListaServicoDriftProvider()))),
		];
	}
}
