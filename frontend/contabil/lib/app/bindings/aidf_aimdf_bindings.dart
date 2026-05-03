import 'package:get/get.dart';
import 'package:contabil/app/controller/aidf_aimdf_controller.dart';
import 'package:contabil/app/data/provider/api/aidf_aimdf_api_provider.dart';
import 'package:contabil/app/data/provider/drift/aidf_aimdf_drift_provider.dart';
import 'package:contabil/app/data/repository/aidf_aimdf_repository.dart';

class AidfAimdfBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<AidfAimdfController>(() => AidfAimdfController(
					aidfAimdfRepository:
							AidfAimdfRepository(aidfAimdfApiProvider: AidfAimdfApiProvider(), aidfAimdfDriftProvider: AidfAimdfDriftProvider()))),
		];
	}
}
