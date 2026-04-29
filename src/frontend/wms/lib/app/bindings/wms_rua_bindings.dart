import 'package:get/get.dart';
import 'package:wms/app/controller/wms_rua_controller.dart';
import 'package:wms/app/data/provider/api/wms_rua_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_rua_drift_provider.dart';
import 'package:wms/app/data/repository/wms_rua_repository.dart';

class WmsRuaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<WmsRuaController>(() => WmsRuaController(
					wmsRuaRepository:
							WmsRuaRepository(wmsRuaApiProvider: WmsRuaApiProvider(), wmsRuaDriftProvider: WmsRuaDriftProvider()))),
		];
	}
}
