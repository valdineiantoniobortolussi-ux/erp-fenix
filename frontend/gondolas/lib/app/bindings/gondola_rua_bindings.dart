import 'package:get/get.dart';
import 'package:gondolas/app/controller/gondola_rua_controller.dart';
import 'package:gondolas/app/data/provider/api/gondola_rua_api_provider.dart';
import 'package:gondolas/app/data/provider/drift/gondola_rua_drift_provider.dart';
import 'package:gondolas/app/data/repository/gondola_rua_repository.dart';

class GondolaRuaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<GondolaRuaController>(() => GondolaRuaController(
					gondolaRuaRepository:
							GondolaRuaRepository(gondolaRuaApiProvider: GondolaRuaApiProvider(), gondolaRuaDriftProvider: GondolaRuaDriftProvider()))),
		];
	}
}
