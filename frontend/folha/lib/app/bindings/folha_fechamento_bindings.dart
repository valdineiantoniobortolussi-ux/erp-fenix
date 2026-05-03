import 'package:get/get.dart';
import 'package:folha/app/controller/folha_fechamento_controller.dart';
import 'package:folha/app/data/provider/api/folha_fechamento_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_fechamento_drift_provider.dart';
import 'package:folha/app/data/repository/folha_fechamento_repository.dart';

class FolhaFechamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaFechamentoController>(() => FolhaFechamentoController(
					folhaFechamentoRepository:
							FolhaFechamentoRepository(folhaFechamentoApiProvider: FolhaFechamentoApiProvider(), folhaFechamentoDriftProvider: FolhaFechamentoDriftProvider()))),
		];
	}
}
