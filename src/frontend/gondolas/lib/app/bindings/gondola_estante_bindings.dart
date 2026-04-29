import 'package:get/get.dart';
import 'package:gondolas/app/controller/gondola_estante_controller.dart';
import 'package:gondolas/app/data/provider/api/gondola_estante_api_provider.dart';
import 'package:gondolas/app/data/provider/drift/gondola_estante_drift_provider.dart';
import 'package:gondolas/app/data/repository/gondola_estante_repository.dart';

class GondolaEstanteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<GondolaEstanteController>(() => GondolaEstanteController(
					gondolaEstanteRepository:
							GondolaEstanteRepository(gondolaEstanteApiProvider: GondolaEstanteApiProvider(), gondolaEstanteDriftProvider: GondolaEstanteDriftProvider()))),
		];
	}
}
