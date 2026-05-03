import 'package:get/get.dart';
import 'package:sped/app/controller/sped_fiscal_controller.dart';
import 'package:sped/app/data/provider/api/sped_fiscal_api_provider.dart';
import 'package:sped/app/data/provider/drift/sped_fiscal_drift_provider.dart';
import 'package:sped/app/data/repository/sped_fiscal_repository.dart';

class SpedFiscalBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<SpedFiscalController>(() => SpedFiscalController(
					spedFiscalRepository:
							SpedFiscalRepository(spedFiscalApiProvider: SpedFiscalApiProvider(), spedFiscalDriftProvider: SpedFiscalDriftProvider()))),
		];
	}
}
