import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_indice_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_indice_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_indice_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_indice_repository.dart';

class ContabilIndiceBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilIndiceController>(() => ContabilIndiceController(
					contabilIndiceRepository:
							ContabilIndiceRepository(contabilIndiceApiProvider: ContabilIndiceApiProvider(), contabilIndiceDriftProvider: ContabilIndiceDriftProvider()))),
		];
	}
}
