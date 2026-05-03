import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_parametro_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_parametro_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_parametro_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_parametro_repository.dart';

class ContabilParametroBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilParametroController>(() => ContabilParametroController(
					contabilParametroRepository:
							ContabilParametroRepository(contabilParametroApiProvider: ContabilParametroApiProvider(), contabilParametroDriftProvider: ContabilParametroDriftProvider()))),
		];
	}
}
