import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_relogio_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_relogio_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_relogio_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_relogio_repository.dart';

class PontoRelogioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoRelogioController>(() => PontoRelogioController(
					pontoRelogioRepository:
							PontoRelogioRepository(pontoRelogioApiProvider: PontoRelogioApiProvider(), pontoRelogioDriftProvider: PontoRelogioDriftProvider()))),
		];
	}
}
