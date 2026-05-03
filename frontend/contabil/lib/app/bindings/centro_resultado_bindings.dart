import 'package:get/get.dart';
import 'package:contabil/app/controller/centro_resultado_controller.dart';
import 'package:contabil/app/data/provider/api/centro_resultado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/centro_resultado_drift_provider.dart';
import 'package:contabil/app/data/repository/centro_resultado_repository.dart';

class CentroResultadoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CentroResultadoController>(() => CentroResultadoController(
					centroResultadoRepository:
							CentroResultadoRepository(centroResultadoApiProvider: CentroResultadoApiProvider(), centroResultadoDriftProvider: CentroResultadoDriftProvider()))),
		];
	}
}
