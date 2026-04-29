import 'package:get/get.dart';
import 'package:cte/app/controller/cte_rodoviario_occ_controller.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_occ_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_occ_drift_provider.dart';
import 'package:cte/app/data/repository/cte_rodoviario_occ_repository.dart';

class CteRodoviarioOccBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteRodoviarioOccController>(() => CteRodoviarioOccController(
					cteRodoviarioOccRepository:
							CteRodoviarioOccRepository(cteRodoviarioOccApiProvider: CteRodoviarioOccApiProvider(), cteRodoviarioOccDriftProvider: CteRodoviarioOccDriftProvider()))),
		];
	}
}
