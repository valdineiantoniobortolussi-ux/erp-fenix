import 'package:get/get.dart';
import 'package:cte/app/controller/cte_cabecalho_controller.dart';
import 'package:cte/app/data/provider/api/cte_cabecalho_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_cabecalho_drift_provider.dart';
import 'package:cte/app/data/repository/cte_cabecalho_repository.dart';

class CteCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteCabecalhoController>(() => CteCabecalhoController(
					cteCabecalhoRepository:
							CteCabecalhoRepository(cteCabecalhoApiProvider: CteCabecalhoApiProvider(), cteCabecalhoDriftProvider: CteCabecalhoDriftProvider()))),
		];
	}
}
