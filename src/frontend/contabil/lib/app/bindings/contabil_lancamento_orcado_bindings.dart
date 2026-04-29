import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_lancamento_orcado_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_lancamento_orcado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_lancamento_orcado_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_lancamento_orcado_repository.dart';

class ContabilLancamentoOrcadoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilLancamentoOrcadoController>(() => ContabilLancamentoOrcadoController(
					contabilLancamentoOrcadoRepository:
							ContabilLancamentoOrcadoRepository(contabilLancamentoOrcadoApiProvider: ContabilLancamentoOrcadoApiProvider(), contabilLancamentoOrcadoDriftProvider: ContabilLancamentoOrcadoDriftProvider()))),
		];
	}
}
