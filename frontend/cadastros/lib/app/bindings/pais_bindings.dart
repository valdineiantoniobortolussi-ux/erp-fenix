import 'package:get/get.dart';
import 'package:cadastros/app/controller/pais_controller.dart';
import 'package:cadastros/app/data/provider/api/pais_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/pais_drift_provider.dart';
import 'package:cadastros/app/data/repository/pais_repository.dart';

class PaisBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PaisController>(() => PaisController(
					paisRepository:
							PaisRepository(paisApiProvider: PaisApiProvider(), paisDriftProvider: PaisDriftProvider()))),
		];
	}
}
