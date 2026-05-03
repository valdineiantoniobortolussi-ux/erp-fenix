import 'package:get/get.dart';
import 'package:orcamentos/app/controller/orcamento_fluxo_caixa_periodo_controller.dart';
import 'package:orcamentos/app/data/provider/api/orcamento_fluxo_caixa_periodo_api_provider.dart';
import 'package:orcamentos/app/data/provider/drift/orcamento_fluxo_caixa_periodo_drift_provider.dart';
import 'package:orcamentos/app/data/repository/orcamento_fluxo_caixa_periodo_repository.dart';

class OrcamentoFluxoCaixaPeriodoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<OrcamentoFluxoCaixaPeriodoController>(() => OrcamentoFluxoCaixaPeriodoController(
					orcamentoFluxoCaixaPeriodoRepository:
							OrcamentoFluxoCaixaPeriodoRepository(orcamentoFluxoCaixaPeriodoApiProvider: OrcamentoFluxoCaixaPeriodoApiProvider(), orcamentoFluxoCaixaPeriodoDriftProvider: OrcamentoFluxoCaixaPeriodoDriftProvider()))),
		];
	}
}
