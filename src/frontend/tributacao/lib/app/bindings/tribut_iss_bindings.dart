import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_iss_controller.dart';
import 'package:tributacao/app/data/provider/api/tribut_iss_api_provider.dart';
import 'package:tributacao/app/data/provider/drift/tribut_iss_drift_provider.dart';
import 'package:tributacao/app/data/repository/tribut_iss_repository.dart';

class TributIssBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TributIssController>(() => TributIssController(
					tributIssRepository:
							TributIssRepository(tributIssApiProvider: TributIssApiProvider(), tributIssDriftProvider: TributIssDriftProvider()))),
		];
	}
}
