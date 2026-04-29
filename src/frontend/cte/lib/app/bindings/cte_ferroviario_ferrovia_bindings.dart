import 'package:get/get.dart';
import 'package:cte/app/controller/cte_ferroviario_ferrovia_controller.dart';
import 'package:cte/app/data/provider/api/cte_ferroviario_ferrovia_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_ferroviario_ferrovia_drift_provider.dart';
import 'package:cte/app/data/repository/cte_ferroviario_ferrovia_repository.dart';

class CteFerroviarioFerroviaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteFerroviarioFerroviaController>(() => CteFerroviarioFerroviaController(
					cteFerroviarioFerroviaRepository:
							CteFerroviarioFerroviaRepository(cteFerroviarioFerroviaApiProvider: CteFerroviarioFerroviaApiProvider(), cteFerroviarioFerroviaDriftProvider: CteFerroviarioFerroviaDriftProvider()))),
		];
	}
}
