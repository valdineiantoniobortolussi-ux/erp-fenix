import 'package:get/get.dart';
import 'package:wms/app/controller/wms_caixa_controller.dart';
import 'package:wms/app/data/provider/api/wms_caixa_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_caixa_drift_provider.dart';
import 'package:wms/app/data/repository/wms_caixa_repository.dart';

class WmsCaixaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<WmsCaixaController>(() => WmsCaixaController(
					wmsCaixaRepository:
							WmsCaixaRepository(wmsCaixaApiProvider: WmsCaixaApiProvider(), wmsCaixaDriftProvider: WmsCaixaDriftProvider()))),
		];
	}
}
