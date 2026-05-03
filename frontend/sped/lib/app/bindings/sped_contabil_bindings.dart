import 'package:get/get.dart';
import 'package:sped/app/controller/sped_contabil_controller.dart';
import 'package:sped/app/data/provider/api/sped_contabil_api_provider.dart';
import 'package:sped/app/data/provider/drift/sped_contabil_drift_provider.dart';
import 'package:sped/app/data/repository/sped_contabil_repository.dart';

class SpedContabilBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<SpedContabilController>(() => SpedContabilController(
					spedContabilRepository:
							SpedContabilRepository(spedContabilApiProvider: SpedContabilApiProvider(), spedContabilDriftProvider: SpedContabilDriftProvider()))),
		];
	}
}
