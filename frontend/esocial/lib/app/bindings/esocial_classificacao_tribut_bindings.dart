import 'package:get/get.dart';
import 'package:esocial/app/controller/esocial_classificacao_tribut_controller.dart';
import 'package:esocial/app/data/provider/api/esocial_classificacao_tribut_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_classificacao_tribut_drift_provider.dart';
import 'package:esocial/app/data/repository/esocial_classificacao_tribut_repository.dart';

class EsocialClassificacaoTributBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EsocialClassificacaoTributController>(() => EsocialClassificacaoTributController(
					esocialClassificacaoTributRepository:
							EsocialClassificacaoTributRepository(esocialClassificacaoTributApiProvider: EsocialClassificacaoTributApiProvider(), esocialClassificacaoTributDriftProvider: EsocialClassificacaoTributDriftProvider()))),
		];
	}
}
