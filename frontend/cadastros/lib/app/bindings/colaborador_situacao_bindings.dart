import 'package:get/get.dart';
import 'package:cadastros/app/controller/colaborador_situacao_controller.dart';
import 'package:cadastros/app/data/provider/api/colaborador_situacao_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/colaborador_situacao_drift_provider.dart';
import 'package:cadastros/app/data/repository/colaborador_situacao_repository.dart';

class ColaboradorSituacaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ColaboradorSituacaoController>(() => ColaboradorSituacaoController(
					colaboradorSituacaoRepository:
							ColaboradorSituacaoRepository(colaboradorSituacaoApiProvider: ColaboradorSituacaoApiProvider(), colaboradorSituacaoDriftProvider: ColaboradorSituacaoDriftProvider()))),
		];
	}
}
