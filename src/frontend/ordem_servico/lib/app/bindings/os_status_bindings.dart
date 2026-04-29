import 'package:get/get.dart';
import 'package:ordem_servico/app/controller/os_status_controller.dart';
import 'package:ordem_servico/app/data/provider/api/os_status_api_provider.dart';
import 'package:ordem_servico/app/data/provider/drift/os_status_drift_provider.dart';
import 'package:ordem_servico/app/data/repository/os_status_repository.dart';

class OsStatusBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<OsStatusController>(() => OsStatusController(
					osStatusRepository:
							OsStatusRepository(osStatusApiProvider: OsStatusApiProvider(), osStatusDriftProvider: OsStatusDriftProvider()))),
		];
	}
}
