import 'package:get/get.dart';
import 'package:wms/app/controller/wms_expedicao_controller.dart';
import 'package:wms/app/data/provider/api/wms_expedicao_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_expedicao_drift_provider.dart';
import 'package:wms/app/data/repository/wms_expedicao_repository.dart';

class WmsExpedicaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<WmsExpedicaoController>(() => WmsExpedicaoController(
					wmsExpedicaoRepository:
							WmsExpedicaoRepository(wmsExpedicaoApiProvider: WmsExpedicaoApiProvider(), wmsExpedicaoDriftProvider: WmsExpedicaoDriftProvider()))),
		];
	}
}
