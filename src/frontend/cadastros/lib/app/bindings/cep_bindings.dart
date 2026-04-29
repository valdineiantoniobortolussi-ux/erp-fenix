import 'package:get/get.dart';
import 'package:cadastros/app/controller/cep_controller.dart';
import 'package:cadastros/app/data/provider/api/cep_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cep_drift_provider.dart';
import 'package:cadastros/app/data/repository/cep_repository.dart';

class CepBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CepController>(() => CepController(
					cepRepository:
							CepRepository(cepApiProvider: CepApiProvider(), cepDriftProvider: CepDriftProvider()))),
		];
	}
}
