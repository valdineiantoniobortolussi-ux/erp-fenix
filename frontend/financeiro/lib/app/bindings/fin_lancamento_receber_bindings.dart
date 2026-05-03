import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_lancamento_receber_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_lancamento_receber_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_lancamento_receber_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_lancamento_receber_repository.dart';

class FinLancamentoReceberBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinLancamentoReceberController>(() => FinLancamentoReceberController(
					finLancamentoReceberRepository:
							FinLancamentoReceberRepository(finLancamentoReceberApiProvider: FinLancamentoReceberApiProvider(), finLancamentoReceberDriftProvider: FinLancamentoReceberDriftProvider()))),
		];
	}
}
