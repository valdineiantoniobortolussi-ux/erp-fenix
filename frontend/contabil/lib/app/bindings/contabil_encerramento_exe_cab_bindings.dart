import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_encerramento_exe_cab_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_encerramento_exe_cab_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_encerramento_exe_cab_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_encerramento_exe_cab_repository.dart';

class ContabilEncerramentoExeCabBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilEncerramentoExeCabController>(() => ContabilEncerramentoExeCabController(
					contabilEncerramentoExeCabRepository:
							ContabilEncerramentoExeCabRepository(contabilEncerramentoExeCabApiProvider: ContabilEncerramentoExeCabApiProvider(), contabilEncerramentoExeCabDriftProvider: ContabilEncerramentoExeCabDriftProvider()))),
		];
	}
}
