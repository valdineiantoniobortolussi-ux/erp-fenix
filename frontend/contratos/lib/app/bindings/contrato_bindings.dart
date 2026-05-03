import 'package:get/get.dart';
import 'package:contratos/app/controller/contrato_controller.dart';
import 'package:contratos/app/data/provider/api/contrato_api_provider.dart';
import 'package:contratos/app/data/provider/drift/contrato_drift_provider.dart';
import 'package:contratos/app/data/repository/contrato_repository.dart';

class ContratoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContratoController>(() => ContratoController(
					contratoRepository:
							ContratoRepository(contratoApiProvider: ContratoApiProvider(), contratoDriftProvider: ContratoDriftProvider()))),
		];
	}
}
