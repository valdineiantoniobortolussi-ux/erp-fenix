import 'package:get/get.dart';
import 'package:wms/app/controller/wms_agendamento_controller.dart';
import 'package:wms/app/data/provider/api/wms_agendamento_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_agendamento_drift_provider.dart';
import 'package:wms/app/data/repository/wms_agendamento_repository.dart';

class WmsAgendamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<WmsAgendamentoController>(() => WmsAgendamentoController(
					wmsAgendamentoRepository:
							WmsAgendamentoRepository(wmsAgendamentoApiProvider: WmsAgendamentoApiProvider(), wmsAgendamentoDriftProvider: WmsAgendamentoDriftProvider()))),
		];
	}
}
