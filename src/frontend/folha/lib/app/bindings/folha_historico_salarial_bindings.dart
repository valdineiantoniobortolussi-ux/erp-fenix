import 'package:get/get.dart';
import 'package:folha/app/controller/folha_historico_salarial_controller.dart';
import 'package:folha/app/data/provider/api/folha_historico_salarial_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_historico_salarial_drift_provider.dart';
import 'package:folha/app/data/repository/folha_historico_salarial_repository.dart';

class FolhaHistoricoSalarialBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaHistoricoSalarialController>(() => FolhaHistoricoSalarialController(
					folhaHistoricoSalarialRepository:
							FolhaHistoricoSalarialRepository(folhaHistoricoSalarialApiProvider: FolhaHistoricoSalarialApiProvider(), folhaHistoricoSalarialDriftProvider: FolhaHistoricoSalarialDriftProvider()))),
		];
	}
}
