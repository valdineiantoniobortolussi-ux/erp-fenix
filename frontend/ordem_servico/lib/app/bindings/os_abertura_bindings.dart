import 'package:get/get.dart';
import 'package:ordem_servico/app/controller/os_abertura_controller.dart';
import 'package:ordem_servico/app/data/provider/api/os_abertura_api_provider.dart';
import 'package:ordem_servico/app/data/provider/drift/os_abertura_drift_provider.dart';
import 'package:ordem_servico/app/data/repository/os_abertura_repository.dart';

class OsAberturaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<OsAberturaController>(() => OsAberturaController(
					osAberturaRepository:
							OsAberturaRepository(osAberturaApiProvider: OsAberturaApiProvider(), osAberturaDriftProvider: OsAberturaDriftProvider()))),
		];
	}
}
