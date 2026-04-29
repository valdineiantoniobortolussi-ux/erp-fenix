import 'package:get/get.dart';
import 'package:cte/app/controller/cte_rodoviario_pedagio_controller.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_pedagio_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_pedagio_drift_provider.dart';
import 'package:cte/app/data/repository/cte_rodoviario_pedagio_repository.dart';

class CteRodoviarioPedagioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteRodoviarioPedagioController>(() => CteRodoviarioPedagioController(
					cteRodoviarioPedagioRepository:
							CteRodoviarioPedagioRepository(cteRodoviarioPedagioApiProvider: CteRodoviarioPedagioApiProvider(), cteRodoviarioPedagioDriftProvider: CteRodoviarioPedagioDriftProvider()))),
		];
	}
}
