import 'package:get/get.dart';
import 'package:contabil/app/controller/registro_cartorio_controller.dart';
import 'package:contabil/app/data/provider/api/registro_cartorio_api_provider.dart';
import 'package:contabil/app/data/provider/drift/registro_cartorio_drift_provider.dart';
import 'package:contabil/app/data/repository/registro_cartorio_repository.dart';

class RegistroCartorioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<RegistroCartorioController>(() => RegistroCartorioController(
					registroCartorioRepository:
							RegistroCartorioRepository(registroCartorioApiProvider: RegistroCartorioApiProvider(), registroCartorioDriftProvider: RegistroCartorioDriftProvider()))),
		];
	}
}
