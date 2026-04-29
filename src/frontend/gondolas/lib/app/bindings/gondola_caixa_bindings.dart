import 'package:get/get.dart';
import 'package:gondolas/app/controller/gondola_caixa_controller.dart';
import 'package:gondolas/app/data/provider/api/gondola_caixa_api_provider.dart';
import 'package:gondolas/app/data/provider/drift/gondola_caixa_drift_provider.dart';
import 'package:gondolas/app/data/repository/gondola_caixa_repository.dart';

class GondolaCaixaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<GondolaCaixaController>(() => GondolaCaixaController(
					gondolaCaixaRepository:
							GondolaCaixaRepository(gondolaCaixaApiProvider: GondolaCaixaApiProvider(), gondolaCaixaDriftProvider: GondolaCaixaDriftProvider()))),
		];
	}
}
