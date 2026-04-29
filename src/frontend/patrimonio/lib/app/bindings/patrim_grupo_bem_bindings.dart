import 'package:get/get.dart';
import 'package:patrimonio/app/controller/patrim_grupo_bem_controller.dart';
import 'package:patrimonio/app/data/provider/api/patrim_grupo_bem_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_grupo_bem_drift_provider.dart';
import 'package:patrimonio/app/data/repository/patrim_grupo_bem_repository.dart';

class PatrimGrupoBemBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PatrimGrupoBemController>(() => PatrimGrupoBemController(
					patrimGrupoBemRepository:
							PatrimGrupoBemRepository(patrimGrupoBemApiProvider: PatrimGrupoBemApiProvider(), patrimGrupoBemDriftProvider: PatrimGrupoBemDriftProvider()))),
		];
	}
}
