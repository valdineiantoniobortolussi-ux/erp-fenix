import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_lancamento_cabecalho_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_lancamento_cabecalho_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_lancamento_cabecalho_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_lancamento_cabecalho_repository.dart';

class ContabilLancamentoCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilLancamentoCabecalhoController>(() => ContabilLancamentoCabecalhoController(
					contabilLancamentoCabecalhoRepository:
							ContabilLancamentoCabecalhoRepository(contabilLancamentoCabecalhoApiProvider: ContabilLancamentoCabecalhoApiProvider(), contabilLancamentoCabecalhoDriftProvider: ContabilLancamentoCabecalhoDriftProvider()))),
		];
	}
}
