import 'package:get/get.dart';
import 'package:contabil/app/controller/rateio_centro_resultado_cab_controller.dart';
import 'package:contabil/app/data/provider/api/rateio_centro_resultado_cab_api_provider.dart';
import 'package:contabil/app/data/provider/drift/rateio_centro_resultado_cab_drift_provider.dart';
import 'package:contabil/app/data/repository/rateio_centro_resultado_cab_repository.dart';

class RateioCentroResultadoCabBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<RateioCentroResultadoCabController>(() => RateioCentroResultadoCabController(
					rateioCentroResultadoCabRepository:
							RateioCentroResultadoCabRepository(rateioCentroResultadoCabApiProvider: RateioCentroResultadoCabApiProvider(), rateioCentroResultadoCabDriftProvider: RateioCentroResultadoCabDriftProvider()))),
		];
	}
}
