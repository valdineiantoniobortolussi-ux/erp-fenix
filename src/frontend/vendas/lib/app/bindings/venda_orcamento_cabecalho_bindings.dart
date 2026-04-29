import 'package:get/get.dart';
import 'package:vendas/app/controller/venda_orcamento_cabecalho_controller.dart';
import 'package:vendas/app/data/provider/api/venda_orcamento_cabecalho_api_provider.dart';
import 'package:vendas/app/data/provider/drift/venda_orcamento_cabecalho_drift_provider.dart';
import 'package:vendas/app/data/repository/venda_orcamento_cabecalho_repository.dart';

class VendaOrcamentoCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<VendaOrcamentoCabecalhoController>(() => VendaOrcamentoCabecalhoController(
					vendaOrcamentoCabecalhoRepository:
							VendaOrcamentoCabecalhoRepository(vendaOrcamentoCabecalhoApiProvider: VendaOrcamentoCabecalhoApiProvider(), vendaOrcamentoCabecalhoDriftProvider: VendaOrcamentoCabecalhoDriftProvider()))),
		];
	}
}
