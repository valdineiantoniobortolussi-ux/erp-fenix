import 'package:get/get.dart';
import 'package:cte/app/controller/cte_ferroviario_vagao_controller.dart';
import 'package:cte/app/data/provider/api/cte_ferroviario_vagao_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_ferroviario_vagao_drift_provider.dart';
import 'package:cte/app/data/repository/cte_ferroviario_vagao_repository.dart';

class CteFerroviarioVagaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteFerroviarioVagaoController>(() => CteFerroviarioVagaoController(
					cteFerroviarioVagaoRepository:
							CteFerroviarioVagaoRepository(cteFerroviarioVagaoApiProvider: CteFerroviarioVagaoApiProvider(), cteFerroviarioVagaoDriftProvider: CteFerroviarioVagaoDriftProvider()))),
		];
	}
}
