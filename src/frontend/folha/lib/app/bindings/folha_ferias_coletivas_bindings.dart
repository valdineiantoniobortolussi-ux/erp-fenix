import 'package:get/get.dart';
import 'package:folha/app/controller/folha_ferias_coletivas_controller.dart';
import 'package:folha/app/data/provider/api/folha_ferias_coletivas_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_ferias_coletivas_drift_provider.dart';
import 'package:folha/app/data/repository/folha_ferias_coletivas_repository.dart';

class FolhaFeriasColetivasBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaFeriasColetivasController>(() => FolhaFeriasColetivasController(
					folhaFeriasColetivasRepository:
							FolhaFeriasColetivasRepository(folhaFeriasColetivasApiProvider: FolhaFeriasColetivasApiProvider(), folhaFeriasColetivasDriftProvider: FolhaFeriasColetivasDriftProvider()))),
		];
	}
}
