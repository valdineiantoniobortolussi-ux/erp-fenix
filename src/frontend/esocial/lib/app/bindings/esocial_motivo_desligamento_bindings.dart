import 'package:get/get.dart';
import 'package:esocial/app/controller/esocial_motivo_desligamento_controller.dart';
import 'package:esocial/app/data/provider/api/esocial_motivo_desligamento_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_motivo_desligamento_drift_provider.dart';
import 'package:esocial/app/data/repository/esocial_motivo_desligamento_repository.dart';

class EsocialMotivoDesligamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EsocialMotivoDesligamentoController>(() => EsocialMotivoDesligamentoController(
					esocialMotivoDesligamentoRepository:
							EsocialMotivoDesligamentoRepository(esocialMotivoDesligamentoApiProvider: EsocialMotivoDesligamentoApiProvider(), esocialMotivoDesligamentoDriftProvider: EsocialMotivoDesligamentoDriftProvider()))),
		];
	}
}
