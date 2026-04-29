import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_horario_autorizado_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_horario_autorizado_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_horario_autorizado_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_horario_autorizado_repository.dart';

class PontoHorarioAutorizadoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoHorarioAutorizadoController>(() => PontoHorarioAutorizadoController(
					pontoHorarioAutorizadoRepository:
							PontoHorarioAutorizadoRepository(pontoHorarioAutorizadoApiProvider: PontoHorarioAutorizadoApiProvider(), pontoHorarioAutorizadoDriftProvider: PontoHorarioAutorizadoDriftProvider()))),
		];
	}
}
