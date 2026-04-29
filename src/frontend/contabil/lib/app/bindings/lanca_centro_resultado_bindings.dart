import 'package:get/get.dart';
import 'package:contabil/app/controller/lanca_centro_resultado_controller.dart';
import 'package:contabil/app/data/provider/api/lanca_centro_resultado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/lanca_centro_resultado_drift_provider.dart';
import 'package:contabil/app/data/repository/lanca_centro_resultado_repository.dart';

class LancaCentroResultadoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<LancaCentroResultadoController>(() => LancaCentroResultadoController(
					lancaCentroResultadoRepository:
							LancaCentroResultadoRepository(lancaCentroResultadoApiProvider: LancaCentroResultadoApiProvider(), lancaCentroResultadoDriftProvider: LancaCentroResultadoDriftProvider()))),
		];
	}
}
