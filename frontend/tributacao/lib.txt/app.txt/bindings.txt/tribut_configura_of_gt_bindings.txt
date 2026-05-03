import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_configura_of_gt_controller.dart';
import 'package:tributacao/app/data/provider/api/tribut_configura_of_gt_api_provider.dart';
import 'package:tributacao/app/data/provider/drift/tribut_configura_of_gt_drift_provider.dart';
import 'package:tributacao/app/data/repository/tribut_configura_of_gt_repository.dart';

class TributConfiguraOfGtBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TributConfiguraOfGtController>(() => TributConfiguraOfGtController(
					tributConfiguraOfGtRepository:
							TributConfiguraOfGtRepository(tributConfiguraOfGtApiProvider: TributConfiguraOfGtApiProvider(), tributConfiguraOfGtDriftProvider: TributConfiguraOfGtDriftProvider()))),
		];
	}
}
