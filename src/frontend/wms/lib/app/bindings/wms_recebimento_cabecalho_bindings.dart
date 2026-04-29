import 'package:get/get.dart';
import 'package:wms/app/controller/wms_recebimento_cabecalho_controller.dart';
import 'package:wms/app/data/provider/api/wms_recebimento_cabecalho_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_recebimento_cabecalho_drift_provider.dart';
import 'package:wms/app/data/repository/wms_recebimento_cabecalho_repository.dart';

class WmsRecebimentoCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<WmsRecebimentoCabecalhoController>(() => WmsRecebimentoCabecalhoController(
					wmsRecebimentoCabecalhoRepository:
							WmsRecebimentoCabecalhoRepository(wmsRecebimentoCabecalhoApiProvider: WmsRecebimentoCabecalhoApiProvider(), wmsRecebimentoCabecalhoDriftProvider: WmsRecebimentoCabecalhoDriftProvider()))),
		];
	}
}
