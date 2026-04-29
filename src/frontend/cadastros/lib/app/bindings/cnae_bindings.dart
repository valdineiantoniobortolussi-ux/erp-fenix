import 'package:get/get.dart';
import 'package:cadastros/app/controller/cnae_controller.dart';
import 'package:cadastros/app/data/provider/api/cnae_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cnae_drift_provider.dart';
import 'package:cadastros/app/data/repository/cnae_repository.dart';

class CnaeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CnaeController>(() => CnaeController(
					cnaeRepository:
							CnaeRepository(cnaeApiProvider: CnaeApiProvider(), cnaeDriftProvider: CnaeDriftProvider()))),
		];
	}
}
