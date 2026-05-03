import 'package:get/get.dart';
import 'package:cadastros/app/controller/setor_controller.dart';
import 'package:cadastros/app/data/provider/api/setor_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/setor_drift_provider.dart';
import 'package:cadastros/app/data/repository/setor_repository.dart';

class SetorBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<SetorController>(() => SetorController(
					setorRepository:
							SetorRepository(setorApiProvider: SetorApiProvider(), setorDriftProvider: SetorDriftProvider()))),
		];
	}
}
