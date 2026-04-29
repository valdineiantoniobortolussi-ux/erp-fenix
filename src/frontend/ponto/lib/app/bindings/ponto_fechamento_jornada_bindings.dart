import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_fechamento_jornada_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_fechamento_jornada_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_fechamento_jornada_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_fechamento_jornada_repository.dart';

class PontoFechamentoJornadaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoFechamentoJornadaController>(() => PontoFechamentoJornadaController(
					pontoFechamentoJornadaRepository:
							PontoFechamentoJornadaRepository(pontoFechamentoJornadaApiProvider: PontoFechamentoJornadaApiProvider(), pontoFechamentoJornadaDriftProvider: PontoFechamentoJornadaDriftProvider()))),
		];
	}
}
