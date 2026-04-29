import 'package:get/get.dart';
import 'package:contabil/app/controller/fap_controller.dart';
import 'package:contabil/app/data/provider/api/fap_api_provider.dart';
import 'package:contabil/app/data/provider/drift/fap_drift_provider.dart';
import 'package:contabil/app/data/repository/fap_repository.dart';

class FapBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FapController>(() => FapController(
					fapRepository:
							FapRepository(fapApiProvider: FapApiProvider(), fapDriftProvider: FapDriftProvider()))),
		];
	}
}
