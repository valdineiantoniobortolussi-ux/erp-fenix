import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_conta_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_conta_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_conta_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_conta_repository.dart';

class ContabilContaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilContaController>(() => ContabilContaController(
					contabilContaRepository:
							ContabilContaRepository(contabilContaApiProvider: ContabilContaApiProvider(), contabilContaDriftProvider: ContabilContaDriftProvider()))),
		];
	}
}
