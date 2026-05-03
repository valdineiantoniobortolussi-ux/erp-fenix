import 'package:get/get.dart';
import 'package:cte/app/controller/cte_inf_nf_carga_lacre_controller.dart';
import 'package:cte/app/data/provider/api/cte_inf_nf_carga_lacre_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_inf_nf_carga_lacre_drift_provider.dart';
import 'package:cte/app/data/repository/cte_inf_nf_carga_lacre_repository.dart';

class CteInfNfCargaLacreBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteInfNfCargaLacreController>(() => CteInfNfCargaLacreController(
					cteInfNfCargaLacreRepository:
							CteInfNfCargaLacreRepository(cteInfNfCargaLacreApiProvider: CteInfNfCargaLacreApiProvider(), cteInfNfCargaLacreDriftProvider: CteInfNfCargaLacreDriftProvider()))),
		];
	}
}
