import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_tipo_pagamento_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_tipo_pagamento_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_tipo_pagamento_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_tipo_pagamento_repository.dart';

class FinTipoPagamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinTipoPagamentoController>(() => FinTipoPagamentoController(
					finTipoPagamentoRepository:
							FinTipoPagamentoRepository(finTipoPagamentoApiProvider: FinTipoPagamentoApiProvider(), finTipoPagamentoDriftProvider: FinTipoPagamentoDriftProvider()))),
		];
	}
}
