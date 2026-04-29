import 'package:get/get.dart';
import 'package:cadastros/app/controller/cst_ipi_controller.dart';
import 'package:cadastros/app/data/provider/api/cst_ipi_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cst_ipi_drift_provider.dart';
import 'package:cadastros/app/data/repository/cst_ipi_repository.dart';

class CstIpiBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CstIpiController>(() => CstIpiController(
					cstIpiRepository:
							CstIpiRepository(cstIpiApiProvider: CstIpiApiProvider(), cstIpiDriftProvider: CstIpiDriftProvider()))),
		];
	}
}
