import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_lancamento_pagar_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_lancamento_pagar_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_lancamento_pagar_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_lancamento_pagar_repository.dart';

class FinLancamentoPagarBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinLancamentoPagarController>(() => FinLancamentoPagarController(
					finLancamentoPagarRepository:
							FinLancamentoPagarRepository(finLancamentoPagarApiProvider: FinLancamentoPagarApiProvider(), finLancamentoPagarDriftProvider: FinLancamentoPagarDriftProvider()))),
		];
	}
}
