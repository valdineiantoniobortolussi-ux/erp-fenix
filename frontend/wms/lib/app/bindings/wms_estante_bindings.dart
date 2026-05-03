import 'package:get/get.dart';
import 'package:wms/app/controller/wms_estante_controller.dart';
import 'package:wms/app/data/provider/api/wms_estante_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_estante_drift_provider.dart';
import 'package:wms/app/data/repository/wms_estante_repository.dart';

class WmsEstanteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<WmsEstanteController>(() => WmsEstanteController(
					wmsEstanteRepository:
							WmsEstanteRepository(wmsEstanteApiProvider: WmsEstanteApiProvider(), wmsEstanteDriftProvider: WmsEstanteDriftProvider()))),
		];
	}
}
