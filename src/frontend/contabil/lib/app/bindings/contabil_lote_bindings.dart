import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_lote_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_lote_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_lote_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_lote_repository.dart';

class ContabilLoteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilLoteController>(() => ContabilLoteController(
					contabilLoteRepository:
							ContabilLoteRepository(contabilLoteApiProvider: ContabilLoteApiProvider(), contabilLoteDriftProvider: ContabilLoteDriftProvider()))),
		];
	}
}
