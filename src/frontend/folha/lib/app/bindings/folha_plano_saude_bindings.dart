import 'package:get/get.dart';
import 'package:folha/app/controller/folha_plano_saude_controller.dart';
import 'package:folha/app/data/provider/api/folha_plano_saude_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_plano_saude_drift_provider.dart';
import 'package:folha/app/data/repository/folha_plano_saude_repository.dart';

class FolhaPlanoSaudeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaPlanoSaudeController>(() => FolhaPlanoSaudeController(
					folhaPlanoSaudeRepository:
							FolhaPlanoSaudeRepository(folhaPlanoSaudeApiProvider: FolhaPlanoSaudeApiProvider(), folhaPlanoSaudeDriftProvider: FolhaPlanoSaudeDriftProvider()))),
		];
	}
}
