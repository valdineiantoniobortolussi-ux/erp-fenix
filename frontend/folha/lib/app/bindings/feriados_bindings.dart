import 'package:get/get.dart';
import 'package:folha/app/controller/feriados_controller.dart';
import 'package:folha/app/data/provider/api/feriados_api_provider.dart';
import 'package:folha/app/data/provider/drift/feriados_drift_provider.dart';
import 'package:folha/app/data/repository/feriados_repository.dart';

class FeriadosBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FeriadosController>(() => FeriadosController(
					feriadosRepository:
							FeriadosRepository(feriadosApiProvider: FeriadosApiProvider(), feriadosDriftProvider: FeriadosDriftProvider()))),
		];
	}
}
