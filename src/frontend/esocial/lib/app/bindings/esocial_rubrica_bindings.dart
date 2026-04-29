import 'package:get/get.dart';
import 'package:esocial/app/controller/esocial_rubrica_controller.dart';
import 'package:esocial/app/data/provider/api/esocial_rubrica_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_rubrica_drift_provider.dart';
import 'package:esocial/app/data/repository/esocial_rubrica_repository.dart';

class EsocialRubricaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EsocialRubricaController>(() => EsocialRubricaController(
					esocialRubricaRepository:
							EsocialRubricaRepository(esocialRubricaApiProvider: EsocialRubricaApiProvider(), esocialRubricaDriftProvider: EsocialRubricaDriftProvider()))),
		];
	}
}
