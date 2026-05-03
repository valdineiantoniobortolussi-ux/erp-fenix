import 'package:get/get.dart';
import 'package:patrimonio/app/controller/patrim_estado_conservacao_controller.dart';
import 'package:patrimonio/app/data/provider/api/patrim_estado_conservacao_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_estado_conservacao_drift_provider.dart';
import 'package:patrimonio/app/data/repository/patrim_estado_conservacao_repository.dart';

class PatrimEstadoConservacaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PatrimEstadoConservacaoController>(() => PatrimEstadoConservacaoController(
					patrimEstadoConservacaoRepository:
							PatrimEstadoConservacaoRepository(patrimEstadoConservacaoApiProvider: PatrimEstadoConservacaoApiProvider(), patrimEstadoConservacaoDriftProvider: PatrimEstadoConservacaoDriftProvider()))),
		];
	}
}
