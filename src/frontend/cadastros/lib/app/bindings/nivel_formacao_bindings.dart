import 'package:get/get.dart';
import 'package:cadastros/app/controller/nivel_formacao_controller.dart';
import 'package:cadastros/app/data/provider/api/nivel_formacao_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/nivel_formacao_drift_provider.dart';
import 'package:cadastros/app/data/repository/nivel_formacao_repository.dart';

class NivelFormacaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NivelFormacaoController>(() => NivelFormacaoController(
					nivelFormacaoRepository:
							NivelFormacaoRepository(nivelFormacaoApiProvider: NivelFormacaoApiProvider(), nivelFormacaoDriftProvider: NivelFormacaoDriftProvider()))),
		];
	}
}
