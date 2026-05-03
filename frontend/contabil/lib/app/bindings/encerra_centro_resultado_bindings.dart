import 'package:get/get.dart';
import 'package:contabil/app/controller/encerra_centro_resultado_controller.dart';
import 'package:contabil/app/data/provider/api/encerra_centro_resultado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/encerra_centro_resultado_drift_provider.dart';
import 'package:contabil/app/data/repository/encerra_centro_resultado_repository.dart';

class EncerraCentroResultadoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EncerraCentroResultadoController>(() => EncerraCentroResultadoController(
					encerraCentroResultadoRepository:
							EncerraCentroResultadoRepository(encerraCentroResultadoApiProvider: EncerraCentroResultadoApiProvider(), encerraCentroResultadoDriftProvider: EncerraCentroResultadoDriftProvider()))),
		];
	}
}
