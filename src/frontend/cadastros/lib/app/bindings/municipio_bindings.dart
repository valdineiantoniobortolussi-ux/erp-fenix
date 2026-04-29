import 'package:get/get.dart';
import 'package:cadastros/app/controller/municipio_controller.dart';
import 'package:cadastros/app/data/provider/api/municipio_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/municipio_drift_provider.dart';
import 'package:cadastros/app/data/repository/municipio_repository.dart';

class MunicipioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MunicipioController>(() => MunicipioController(
					municipioRepository:
							MunicipioRepository(municipioApiProvider: MunicipioApiProvider(), municipioDriftProvider: MunicipioDriftProvider()))),
		];
	}
}
