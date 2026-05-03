import 'package:get/get.dart';
import 'package:administrativo/app/controller/papel_controller.dart';
import 'package:administrativo/app/data/provider/api/papel_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/papel_drift_provider.dart';
import 'package:administrativo/app/data/repository/papel_repository.dart';

class PapelBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PapelController>(() => PapelController(
					repository: PapelRepository(papelApiProvider: PapelApiProvider(), papelDriftProvider: PapelDriftProvider()))),
		];
	}
}
