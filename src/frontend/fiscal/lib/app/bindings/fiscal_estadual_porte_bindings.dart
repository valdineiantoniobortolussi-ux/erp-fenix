import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_estadual_porte_controller.dart';
import 'package:fiscal/app/data/provider/api/fiscal_estadual_porte_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_estadual_porte_drift_provider.dart';
import 'package:fiscal/app/data/repository/fiscal_estadual_porte_repository.dart';

class FiscalEstadualPorteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FiscalEstadualPorteController>(() => FiscalEstadualPorteController(
					fiscalEstadualPorteRepository:
							FiscalEstadualPorteRepository(fiscalEstadualPorteApiProvider: FiscalEstadualPorteApiProvider(), fiscalEstadualPorteDriftProvider: FiscalEstadualPorteDriftProvider()))),
		];
	}
}
