import 'package:get/get.dart';
import 'package:esocial/app/controller/esocial_natureza_juridica_controller.dart';
import 'package:esocial/app/data/provider/api/esocial_natureza_juridica_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_natureza_juridica_drift_provider.dart';
import 'package:esocial/app/data/repository/esocial_natureza_juridica_repository.dart';

class EsocialNaturezaJuridicaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EsocialNaturezaJuridicaController>(() => EsocialNaturezaJuridicaController(
					esocialNaturezaJuridicaRepository:
							EsocialNaturezaJuridicaRepository(esocialNaturezaJuridicaApiProvider: EsocialNaturezaJuridicaApiProvider(), esocialNaturezaJuridicaDriftProvider: EsocialNaturezaJuridicaDriftProvider()))),
		];
	}
}
