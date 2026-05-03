import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_icms_custom_cab_controller.dart';
import 'package:tributacao/app/data/provider/api/tribut_icms_custom_cab_api_provider.dart';
import 'package:tributacao/app/data/provider/drift/tribut_icms_custom_cab_drift_provider.dart';
import 'package:tributacao/app/data/repository/tribut_icms_custom_cab_repository.dart';

class TributIcmsCustomCabBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TributIcmsCustomCabController>(() => TributIcmsCustomCabController(
					tributIcmsCustomCabRepository:
							TributIcmsCustomCabRepository(tributIcmsCustomCabApiProvider: TributIcmsCustomCabApiProvider(), tributIcmsCustomCabDriftProvider: TributIcmsCustomCabDriftProvider()))),
		];
	}
}
