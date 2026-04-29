import 'package:get/get.dart';
import 'package:contabil/app/controller/plano_centro_resultado_controller.dart';
import 'package:contabil/app/data/provider/api/plano_centro_resultado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/plano_centro_resultado_drift_provider.dart';
import 'package:contabil/app/data/repository/plano_centro_resultado_repository.dart';

class PlanoCentroResultadoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PlanoCentroResultadoController>(() => PlanoCentroResultadoController(
					planoCentroResultadoRepository:
							PlanoCentroResultadoRepository(planoCentroResultadoApiProvider: PlanoCentroResultadoApiProvider(), planoCentroResultadoDriftProvider: PlanoCentroResultadoDriftProvider()))),
		];
	}
}
