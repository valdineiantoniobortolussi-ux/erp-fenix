import 'package:get/get.dart';
import 'package:agenda/app/controller/recado_remetente_controller.dart';
import 'package:agenda/app/data/provider/api/recado_remetente_api_provider.dart';
import 'package:agenda/app/data/provider/drift/recado_remetente_drift_provider.dart';
import 'package:agenda/app/data/repository/recado_remetente_repository.dart';

class RecadoRemetenteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<RecadoRemetenteController>(() => RecadoRemetenteController(
					recadoRemetenteRepository:
							RecadoRemetenteRepository(recadoRemetenteApiProvider: RecadoRemetenteApiProvider(), recadoRemetenteDriftProvider: RecadoRemetenteDriftProvider()))),
		];
	}
}
