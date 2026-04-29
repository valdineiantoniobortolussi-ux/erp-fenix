import 'package:get/get.dart';
import 'package:cte/app/controller/cte_documento_anterior_id_controller.dart';
import 'package:cte/app/data/provider/api/cte_documento_anterior_id_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_documento_anterior_id_drift_provider.dart';
import 'package:cte/app/data/repository/cte_documento_anterior_id_repository.dart';

class CteDocumentoAnteriorIdBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteDocumentoAnteriorIdController>(() => CteDocumentoAnteriorIdController(
					cteDocumentoAnteriorIdRepository:
							CteDocumentoAnteriorIdRepository(cteDocumentoAnteriorIdApiProvider: CteDocumentoAnteriorIdApiProvider(), cteDocumentoAnteriorIdDriftProvider: CteDocumentoAnteriorIdDriftProvider()))),
		];
	}
}
