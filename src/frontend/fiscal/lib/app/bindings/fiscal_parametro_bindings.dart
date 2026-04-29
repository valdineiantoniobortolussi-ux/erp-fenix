import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_parametro_controller.dart';
import 'package:fiscal/app/data/provider/api/fiscal_parametro_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_parametro_drift_provider.dart';
import 'package:fiscal/app/data/repository/fiscal_parametro_repository.dart';

class FiscalParametroBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FiscalParametroController>(() => FiscalParametroController(
					fiscalParametroRepository:
							FiscalParametroRepository(fiscalParametroApiProvider: FiscalParametroApiProvider(), fiscalParametroDriftProvider: FiscalParametroDriftProvider()))),
		];
	}
}
