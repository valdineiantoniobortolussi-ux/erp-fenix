import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_detalhe_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_detalhe_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_detalhe_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_detalhe_repository.dart';

class NfeDetalheBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeDetalheController>(() => NfeDetalheController(
					nfeDetalheRepository:
							NfeDetalheRepository(nfeDetalheApiProvider: NfeDetalheApiProvider(), nfeDetalheDriftProvider: NfeDetalheDriftProvider()))),
		];
	}
}
