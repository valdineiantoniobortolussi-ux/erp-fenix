import 'package:get/get.dart';
import 'package:vendas/app/controller/venda_condicoes_pagamento_controller.dart';
import 'package:vendas/app/data/provider/api/venda_condicoes_pagamento_api_provider.dart';
import 'package:vendas/app/data/provider/drift/venda_condicoes_pagamento_drift_provider.dart';
import 'package:vendas/app/data/repository/venda_condicoes_pagamento_repository.dart';

class VendaCondicoesPagamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<VendaCondicoesPagamentoController>(() => VendaCondicoesPagamentoController(
					vendaCondicoesPagamentoRepository:
							VendaCondicoesPagamentoRepository(vendaCondicoesPagamentoApiProvider: VendaCondicoesPagamentoApiProvider(), vendaCondicoesPagamentoDriftProvider: VendaCondicoesPagamentoDriftProvider()))),
		];
	}
}
