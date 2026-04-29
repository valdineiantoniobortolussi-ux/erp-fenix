import 'package:get/get.dart';
import 'package:cte/app/controller/cte_inf_nf_transporte_lacre_controller.dart';
import 'package:cte/app/data/provider/api/cte_inf_nf_transporte_lacre_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_inf_nf_transporte_lacre_drift_provider.dart';
import 'package:cte/app/data/repository/cte_inf_nf_transporte_lacre_repository.dart';

class CteInfNfTransporteLacreBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteInfNfTransporteLacreController>(() => CteInfNfTransporteLacreController(
					cteInfNfTransporteLacreRepository:
							CteInfNfTransporteLacreRepository(cteInfNfTransporteLacreApiProvider: CteInfNfTransporteLacreApiProvider(), cteInfNfTransporteLacreDriftProvider: CteInfNfTransporteLacreDriftProvider()))),
		];
	}
}
