import 'package:get/get.dart';
import 'package:cadastros/app/controller/sindicato_controller.dart';
import 'package:cadastros/app/data/provider/api/sindicato_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/sindicato_drift_provider.dart';
import 'package:cadastros/app/data/repository/sindicato_repository.dart';

class SindicatoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<SindicatoController>(() => SindicatoController(
					sindicatoRepository:
							SindicatoRepository(sindicatoApiProvider: SindicatoApiProvider(), sindicatoDriftProvider: SindicatoDriftProvider()))),
		];
	}
}
