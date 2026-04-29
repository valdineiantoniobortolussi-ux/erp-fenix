import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_numero_inutilizado_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_numero_inutilizado_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_numero_inutilizado_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_numero_inutilizado_repository.dart';

class NfeNumeroInutilizadoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeNumeroInutilizadoController>(() => NfeNumeroInutilizadoController(
					nfeNumeroInutilizadoRepository:
							NfeNumeroInutilizadoRepository(nfeNumeroInutilizadoApiProvider: NfeNumeroInutilizadoApiProvider(), nfeNumeroInutilizadoDriftProvider: NfeNumeroInutilizadoDriftProvider()))),
		];
	}
}
