import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_conta_rateio_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_conta_rateio_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_conta_rateio_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_conta_rateio_repository.dart';

class ContabilContaRateioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilContaRateioController>(() => ContabilContaRateioController(
					contabilContaRateioRepository:
							ContabilContaRateioRepository(contabilContaRateioApiProvider: ContabilContaRateioApiProvider(), contabilContaRateioDriftProvider: ContabilContaRateioDriftProvider()))),
		];
	}
}
