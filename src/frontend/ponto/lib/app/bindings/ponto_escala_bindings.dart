import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_escala_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_escala_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_escala_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_escala_repository.dart';

class PontoEscalaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoEscalaController>(() => PontoEscalaController(
					pontoEscalaRepository:
							PontoEscalaRepository(pontoEscalaApiProvider: PontoEscalaApiProvider(), pontoEscalaDriftProvider: PontoEscalaDriftProvider()))),
		];
	}
}
