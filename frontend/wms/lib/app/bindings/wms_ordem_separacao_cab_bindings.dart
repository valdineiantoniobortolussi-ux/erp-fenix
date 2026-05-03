import 'package:get/get.dart';
import 'package:wms/app/controller/wms_ordem_separacao_cab_controller.dart';
import 'package:wms/app/data/provider/api/wms_ordem_separacao_cab_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_ordem_separacao_cab_drift_provider.dart';
import 'package:wms/app/data/repository/wms_ordem_separacao_cab_repository.dart';

class WmsOrdemSeparacaoCabBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<WmsOrdemSeparacaoCabController>(() => WmsOrdemSeparacaoCabController(
					wmsOrdemSeparacaoCabRepository:
							WmsOrdemSeparacaoCabRepository(wmsOrdemSeparacaoCabApiProvider: WmsOrdemSeparacaoCabApiProvider(), wmsOrdemSeparacaoCabDriftProvider: WmsOrdemSeparacaoCabDriftProvider()))),
		];
	}
}
