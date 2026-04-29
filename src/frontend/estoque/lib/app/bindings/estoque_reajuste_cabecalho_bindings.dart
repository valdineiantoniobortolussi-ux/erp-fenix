import 'package:get/get.dart';
import 'package:estoque/app/controller/estoque_reajuste_cabecalho_controller.dart';
import 'package:estoque/app/data/provider/api/estoque_reajuste_cabecalho_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_reajuste_cabecalho_drift_provider.dart';
import 'package:estoque/app/data/repository/estoque_reajuste_cabecalho_repository.dart';

class EstoqueReajusteCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EstoqueReajusteCabecalhoController>(() => EstoqueReajusteCabecalhoController(
					estoqueReajusteCabecalhoRepository:
							EstoqueReajusteCabecalhoRepository(estoqueReajusteCabecalhoApiProvider: EstoqueReajusteCabecalhoApiProvider(), estoqueReajusteCabecalhoDriftProvider: EstoqueReajusteCabecalhoDriftProvider()))),
		];
	}
}
