import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_fechamento_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_fechamento_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_fechamento_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_fechamento_repository.dart';

class ContabilFechamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilFechamentoController>(() => ContabilFechamentoController(
					contabilFechamentoRepository:
							ContabilFechamentoRepository(contabilFechamentoApiProvider: ContabilFechamentoApiProvider(), contabilFechamentoDriftProvider: ContabilFechamentoDriftProvider()))),
		];
	}
}
