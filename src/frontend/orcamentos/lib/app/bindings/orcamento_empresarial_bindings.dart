import 'package:get/get.dart';
import 'package:orcamentos/app/controller/orcamento_empresarial_controller.dart';
import 'package:orcamentos/app/data/provider/api/orcamento_empresarial_api_provider.dart';
import 'package:orcamentos/app/data/provider/drift/orcamento_empresarial_drift_provider.dart';
import 'package:orcamentos/app/data/repository/orcamento_empresarial_repository.dart';

class OrcamentoEmpresarialBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<OrcamentoEmpresarialController>(() => OrcamentoEmpresarialController(
					orcamentoEmpresarialRepository:
							OrcamentoEmpresarialRepository(orcamentoEmpresarialApiProvider: OrcamentoEmpresarialApiProvider(), orcamentoEmpresarialDriftProvider: OrcamentoEmpresarialDriftProvider()))),
		];
	}
}
