import 'package:get/get.dart';
import 'package:folha/app/controller/operadora_plano_saude_controller.dart';
import 'package:folha/app/data/provider/api/operadora_plano_saude_api_provider.dart';
import 'package:folha/app/data/provider/drift/operadora_plano_saude_drift_provider.dart';
import 'package:folha/app/data/repository/operadora_plano_saude_repository.dart';

class OperadoraPlanoSaudeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<OperadoraPlanoSaudeController>(() => OperadoraPlanoSaudeController(
					operadoraPlanoSaudeRepository:
							OperadoraPlanoSaudeRepository(operadoraPlanoSaudeApiProvider: OperadoraPlanoSaudeApiProvider(), operadoraPlanoSaudeDriftProvider: OperadoraPlanoSaudeDriftProvider()))),
		];
	}
}
