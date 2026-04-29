import 'package:get/get.dart';
import 'package:contabil/app/controller/plano_conta_ref_sped_controller.dart';
import 'package:contabil/app/data/provider/api/plano_conta_ref_sped_api_provider.dart';
import 'package:contabil/app/data/provider/drift/plano_conta_ref_sped_drift_provider.dart';
import 'package:contabil/app/data/repository/plano_conta_ref_sped_repository.dart';

class PlanoContaRefSpedBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PlanoContaRefSpedController>(() => PlanoContaRefSpedController(
					planoContaRefSpedRepository:
							PlanoContaRefSpedRepository(planoContaRefSpedApiProvider: PlanoContaRefSpedApiProvider(), planoContaRefSpedDriftProvider: PlanoContaRefSpedDriftProvider()))),
		];
	}
}
