import 'package:get/get.dart';
import 'package:cadastros/app/controller/estado_civil_controller.dart';
import 'package:cadastros/app/data/provider/api/estado_civil_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/estado_civil_drift_provider.dart';
import 'package:cadastros/app/data/repository/estado_civil_repository.dart';

class EstadoCivilBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EstadoCivilController>(() => EstadoCivilController(
					estadoCivilRepository:
							EstadoCivilRepository(estadoCivilApiProvider: EstadoCivilApiProvider(), estadoCivilDriftProvider: EstadoCivilDriftProvider()))),
		];
	}
}
