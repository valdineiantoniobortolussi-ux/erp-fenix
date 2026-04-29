import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_horario_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_horario_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_horario_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_horario_repository.dart';

class PontoHorarioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoHorarioController>(() => PontoHorarioController(
					pontoHorarioRepository:
							PontoHorarioRepository(pontoHorarioApiProvider: PontoHorarioApiProvider(), pontoHorarioDriftProvider: PontoHorarioDriftProvider()))),
		];
	}
}
