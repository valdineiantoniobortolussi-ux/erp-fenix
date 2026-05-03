import 'package:get/get.dart';
import 'package:wms/app/controller/wms_parametro_controller.dart';
import 'package:wms/app/data/provider/api/wms_parametro_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_parametro_drift_provider.dart';
import 'package:wms/app/data/repository/wms_parametro_repository.dart';

class WmsParametroBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<WmsParametroController>(() => WmsParametroController(
					wmsParametroRepository:
							WmsParametroRepository(wmsParametroApiProvider: WmsParametroApiProvider(), wmsParametroDriftProvider: WmsParametroDriftProvider()))),
		];
	}
}
