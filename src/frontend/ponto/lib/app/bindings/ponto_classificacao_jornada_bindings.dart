import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_classificacao_jornada_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_classificacao_jornada_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_classificacao_jornada_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_classificacao_jornada_repository.dart';

class PontoClassificacaoJornadaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoClassificacaoJornadaController>(() => PontoClassificacaoJornadaController(
					pontoClassificacaoJornadaRepository:
							PontoClassificacaoJornadaRepository(pontoClassificacaoJornadaApiProvider: PontoClassificacaoJornadaApiProvider(), pontoClassificacaoJornadaDriftProvider: PontoClassificacaoJornadaDriftProvider()))),
		];
	}
}
