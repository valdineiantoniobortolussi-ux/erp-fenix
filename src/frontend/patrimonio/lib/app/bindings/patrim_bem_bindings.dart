import 'package:get/get.dart';
import 'package:patrimonio/app/controller/patrim_bem_controller.dart';
import 'package:patrimonio/app/data/provider/api/patrim_bem_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_bem_drift_provider.dart';
import 'package:patrimonio/app/data/repository/patrim_bem_repository.dart';

class PatrimBemBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PatrimBemController>(() => PatrimBemController(
					patrimBemRepository:
							PatrimBemRepository(patrimBemApiProvider: PatrimBemApiProvider(), patrimBemDriftProvider: PatrimBemDriftProvider()))),
		];
	}
}
