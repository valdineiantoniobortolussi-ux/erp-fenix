import 'package:get/get.dart';
import 'package:cadastros/app/controller/uf_controller.dart';
import 'package:cadastros/app/data/provider/api/uf_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/uf_drift_provider.dart';
import 'package:cadastros/app/data/repository/uf_repository.dart';

class UfBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<UfController>(() => UfController(
					ufRepository:
							UfRepository(ufApiProvider: UfApiProvider(), ufDriftProvider: UfDriftProvider()))),
		];
	}
}
