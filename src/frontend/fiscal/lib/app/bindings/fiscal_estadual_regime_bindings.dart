import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_estadual_regime_controller.dart';
import 'package:fiscal/app/data/provider/api/fiscal_estadual_regime_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_estadual_regime_drift_provider.dart';
import 'package:fiscal/app/data/repository/fiscal_estadual_regime_repository.dart';

class FiscalEstadualRegimeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FiscalEstadualRegimeController>(() => FiscalEstadualRegimeController(
					fiscalEstadualRegimeRepository:
							FiscalEstadualRegimeRepository(fiscalEstadualRegimeApiProvider: FiscalEstadualRegimeApiProvider(), fiscalEstadualRegimeDriftProvider: FiscalEstadualRegimeDriftProvider()))),
		];
	}
}
