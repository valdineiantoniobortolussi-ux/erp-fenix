import 'package:get/get.dart';
import 'package:orcamentos/app/controller/orcamento_periodo_controller.dart';
import 'package:orcamentos/app/data/provider/api/orcamento_periodo_api_provider.dart';
import 'package:orcamentos/app/data/provider/drift/orcamento_periodo_drift_provider.dart';
import 'package:orcamentos/app/data/repository/orcamento_periodo_repository.dart';

class OrcamentoPeriodoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<OrcamentoPeriodoController>(() => OrcamentoPeriodoController(
					orcamentoPeriodoRepository:
							OrcamentoPeriodoRepository(orcamentoPeriodoApiProvider: OrcamentoPeriodoApiProvider(), orcamentoPeriodoDriftProvider: OrcamentoPeriodoDriftProvider()))),
		];
	}
}
