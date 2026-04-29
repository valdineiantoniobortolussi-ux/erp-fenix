import 'package:get/get.dart';
import 'package:cte/app/controller/cte_aquaviario_balsa_controller.dart';
import 'package:cte/app/data/provider/api/cte_aquaviario_balsa_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_aquaviario_balsa_drift_provider.dart';
import 'package:cte/app/data/repository/cte_aquaviario_balsa_repository.dart';

class CteAquaviarioBalsaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteAquaviarioBalsaController>(() => CteAquaviarioBalsaController(
					cteAquaviarioBalsaRepository:
							CteAquaviarioBalsaRepository(cteAquaviarioBalsaApiProvider: CteAquaviarioBalsaApiProvider(), cteAquaviarioBalsaDriftProvider: CteAquaviarioBalsaDriftProvider()))),
		];
	}
}
