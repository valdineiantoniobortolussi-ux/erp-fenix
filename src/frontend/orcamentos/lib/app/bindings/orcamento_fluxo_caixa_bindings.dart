import 'package:get/get.dart';
import 'package:orcamentos/app/controller/orcamento_fluxo_caixa_controller.dart';
import 'package:orcamentos/app/data/provider/api/orcamento_fluxo_caixa_api_provider.dart';
import 'package:orcamentos/app/data/provider/drift/orcamento_fluxo_caixa_drift_provider.dart';
import 'package:orcamentos/app/data/repository/orcamento_fluxo_caixa_repository.dart';

class OrcamentoFluxoCaixaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<OrcamentoFluxoCaixaController>(() => OrcamentoFluxoCaixaController(
					orcamentoFluxoCaixaRepository:
							OrcamentoFluxoCaixaRepository(orcamentoFluxoCaixaApiProvider: OrcamentoFluxoCaixaApiProvider(), orcamentoFluxoCaixaDriftProvider: OrcamentoFluxoCaixaDriftProvider()))),
		];
	}
}
