import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_municipal_regime_controller.dart';
import 'package:fiscal/app/data/provider/api/fiscal_municipal_regime_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_municipal_regime_drift_provider.dart';
import 'package:fiscal/app/data/repository/fiscal_municipal_regime_repository.dart';

class FiscalMunicipalRegimeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FiscalMunicipalRegimeController>(() => FiscalMunicipalRegimeController(
					fiscalMunicipalRegimeRepository:
							FiscalMunicipalRegimeRepository(fiscalMunicipalRegimeApiProvider: FiscalMunicipalRegimeApiProvider(), fiscalMunicipalRegimeDriftProvider: FiscalMunicipalRegimeDriftProvider()))),
		];
	}
}
