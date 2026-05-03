import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_rodoviario_pedagio_controller.dart';
import 'package:mdfe/app/data/provider/api/mdfe_rodoviario_pedagio_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_rodoviario_pedagio_drift_provider.dart';
import 'package:mdfe/app/data/repository/mdfe_rodoviario_pedagio_repository.dart';

class MdfeRodoviarioPedagioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MdfeRodoviarioPedagioController>(() => MdfeRodoviarioPedagioController(
					mdfeRodoviarioPedagioRepository:
							MdfeRodoviarioPedagioRepository(mdfeRodoviarioPedagioApiProvider: MdfeRodoviarioPedagioApiProvider(), mdfeRodoviarioPedagioDriftProvider: MdfeRodoviarioPedagioDriftProvider()))),
		];
	}
}
