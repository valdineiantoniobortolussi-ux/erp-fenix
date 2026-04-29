import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_apuracao_icms_controller.dart';
import 'package:fiscal/app/data/provider/api/fiscal_apuracao_icms_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_apuracao_icms_drift_provider.dart';
import 'package:fiscal/app/data/repository/fiscal_apuracao_icms_repository.dart';

class FiscalApuracaoIcmsBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FiscalApuracaoIcmsController>(() => FiscalApuracaoIcmsController(
					fiscalApuracaoIcmsRepository:
							FiscalApuracaoIcmsRepository(fiscalApuracaoIcmsApiProvider: FiscalApuracaoIcmsApiProvider(), fiscalApuracaoIcmsDriftProvider: FiscalApuracaoIcmsDriftProvider()))),
		];
	}
}
