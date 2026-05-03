import 'package:get/get.dart';
import 'package:folha/app/controller/ferias_periodo_aquisitivo_controller.dart';
import 'package:folha/app/data/provider/api/ferias_periodo_aquisitivo_api_provider.dart';
import 'package:folha/app/data/provider/drift/ferias_periodo_aquisitivo_drift_provider.dart';
import 'package:folha/app/data/repository/ferias_periodo_aquisitivo_repository.dart';

class FeriasPeriodoAquisitivoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FeriasPeriodoAquisitivoController>(() => FeriasPeriodoAquisitivoController(
					feriasPeriodoAquisitivoRepository:
							FeriasPeriodoAquisitivoRepository(feriasPeriodoAquisitivoApiProvider: FeriasPeriodoAquisitivoApiProvider(), feriasPeriodoAquisitivoDriftProvider: FeriasPeriodoAquisitivoDriftProvider()))),
		];
	}
}
