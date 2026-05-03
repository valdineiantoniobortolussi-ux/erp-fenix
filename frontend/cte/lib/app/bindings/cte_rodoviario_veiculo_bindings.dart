import 'package:get/get.dart';
import 'package:cte/app/controller/cte_rodoviario_veiculo_controller.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_veiculo_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_veiculo_drift_provider.dart';
import 'package:cte/app/data/repository/cte_rodoviario_veiculo_repository.dart';

class CteRodoviarioVeiculoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteRodoviarioVeiculoController>(() => CteRodoviarioVeiculoController(
					cteRodoviarioVeiculoRepository:
							CteRodoviarioVeiculoRepository(cteRodoviarioVeiculoApiProvider: CteRodoviarioVeiculoApiProvider(), cteRodoviarioVeiculoDriftProvider: CteRodoviarioVeiculoDriftProvider()))),
		];
	}
}
