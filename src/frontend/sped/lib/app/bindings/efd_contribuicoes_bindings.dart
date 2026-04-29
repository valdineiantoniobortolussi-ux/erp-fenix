import 'package:get/get.dart';
import 'package:sped/app/controller/efd_contribuicoes_controller.dart';
import 'package:sped/app/data/provider/api/efd_contribuicoes_api_provider.dart';
import 'package:sped/app/data/provider/drift/efd_contribuicoes_drift_provider.dart';
import 'package:sped/app/data/repository/efd_contribuicoes_repository.dart';

class EfdContribuicoesBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EfdContribuicoesController>(() => EfdContribuicoesController(
					efdContribuicoesRepository:
							EfdContribuicoesRepository(efdContribuicoesApiProvider: EfdContribuicoesApiProvider(), efdContribuicoesDriftProvider: EfdContribuicoesDriftProvider()))),
		];
	}
}
