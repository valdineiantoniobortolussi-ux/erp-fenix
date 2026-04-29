import 'package:get/get.dart';
import 'package:ordem_servico/app/controller/os_equipamento_controller.dart';
import 'package:ordem_servico/app/data/provider/api/os_equipamento_api_provider.dart';
import 'package:ordem_servico/app/data/provider/drift/os_equipamento_drift_provider.dart';
import 'package:ordem_servico/app/data/repository/os_equipamento_repository.dart';

class OsEquipamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<OsEquipamentoController>(() => OsEquipamentoController(
					osEquipamentoRepository:
							OsEquipamentoRepository(osEquipamentoApiProvider: OsEquipamentoApiProvider(), osEquipamentoDriftProvider: OsEquipamentoDriftProvider()))),
		];
	}
}
