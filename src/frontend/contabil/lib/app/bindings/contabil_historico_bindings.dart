import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_historico_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_historico_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_historico_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_historico_repository.dart';

class ContabilHistoricoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilHistoricoController>(() => ContabilHistoricoController(
					contabilHistoricoRepository:
							ContabilHistoricoRepository(contabilHistoricoApiProvider: ContabilHistoricoApiProvider(), contabilHistoricoDriftProvider: ContabilHistoricoDriftProvider()))),
		];
	}
}
