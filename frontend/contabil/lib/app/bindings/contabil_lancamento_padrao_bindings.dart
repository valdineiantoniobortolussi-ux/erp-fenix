import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_lancamento_padrao_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_lancamento_padrao_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_lancamento_padrao_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_lancamento_padrao_repository.dart';

class ContabilLancamentoPadraoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilLancamentoPadraoController>(() => ContabilLancamentoPadraoController(
					contabilLancamentoPadraoRepository:
							ContabilLancamentoPadraoRepository(contabilLancamentoPadraoApiProvider: ContabilLancamentoPadraoApiProvider(), contabilLancamentoPadraoDriftProvider: ContabilLancamentoPadraoDriftProvider()))),
		];
	}
}
