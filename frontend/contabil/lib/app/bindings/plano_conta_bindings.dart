import 'package:get/get.dart';
import 'package:contabil/app/controller/plano_conta_controller.dart';
import 'package:contabil/app/data/provider/api/plano_conta_api_provider.dart';
import 'package:contabil/app/data/provider/drift/plano_conta_drift_provider.dart';
import 'package:contabil/app/data/repository/plano_conta_repository.dart';

class PlanoContaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PlanoContaController>(() => PlanoContaController(
					planoContaRepository:
							PlanoContaRepository(planoContaApiProvider: PlanoContaApiProvider(), planoContaDriftProvider: PlanoContaDriftProvider()))),
		];
	}
}
