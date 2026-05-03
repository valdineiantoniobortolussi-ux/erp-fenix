import 'package:get/get.dart';
import 'package:esocial/app/controller/esocial_tipo_afastamento_controller.dart';
import 'package:esocial/app/data/provider/api/esocial_tipo_afastamento_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_tipo_afastamento_drift_provider.dart';
import 'package:esocial/app/data/repository/esocial_tipo_afastamento_repository.dart';

class EsocialTipoAfastamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EsocialTipoAfastamentoController>(() => EsocialTipoAfastamentoController(
					esocialTipoAfastamentoRepository:
							EsocialTipoAfastamentoRepository(esocialTipoAfastamentoApiProvider: EsocialTipoAfastamentoApiProvider(), esocialTipoAfastamentoDriftProvider: EsocialTipoAfastamentoDriftProvider()))),
		];
	}
}
