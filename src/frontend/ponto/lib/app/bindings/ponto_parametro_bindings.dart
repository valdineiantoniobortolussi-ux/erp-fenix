import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_parametro_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_parametro_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_parametro_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_parametro_repository.dart';

class PontoParametroBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoParametroController>(() => PontoParametroController(
					pontoParametroRepository:
							PontoParametroRepository(pontoParametroApiProvider: PontoParametroApiProvider(), pontoParametroDriftProvider: PontoParametroDriftProvider()))),
		];
	}
}
