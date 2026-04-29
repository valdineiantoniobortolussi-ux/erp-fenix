import 'package:get/get.dart';
import 'package:cte/app/controller/cte_rodoviario_motorista_controller.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_motorista_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_motorista_drift_provider.dart';
import 'package:cte/app/data/repository/cte_rodoviario_motorista_repository.dart';

class CteRodoviarioMotoristaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteRodoviarioMotoristaController>(() => CteRodoviarioMotoristaController(
					cteRodoviarioMotoristaRepository:
							CteRodoviarioMotoristaRepository(cteRodoviarioMotoristaApiProvider: CteRodoviarioMotoristaApiProvider(), cteRodoviarioMotoristaDriftProvider: CteRodoviarioMotoristaDriftProvider()))),
		];
	}
}
