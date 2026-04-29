import 'package:get/get.dart';
import 'package:patrimonio/app/controller/patrim_indice_atualizacao_controller.dart';
import 'package:patrimonio/app/data/provider/api/patrim_indice_atualizacao_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_indice_atualizacao_drift_provider.dart';
import 'package:patrimonio/app/data/repository/patrim_indice_atualizacao_repository.dart';

class PatrimIndiceAtualizacaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PatrimIndiceAtualizacaoController>(() => PatrimIndiceAtualizacaoController(
					patrimIndiceAtualizacaoRepository:
							PatrimIndiceAtualizacaoRepository(patrimIndiceAtualizacaoApiProvider: PatrimIndiceAtualizacaoApiProvider(), patrimIndiceAtualizacaoDriftProvider: PatrimIndiceAtualizacaoDriftProvider()))),
		];
	}
}
