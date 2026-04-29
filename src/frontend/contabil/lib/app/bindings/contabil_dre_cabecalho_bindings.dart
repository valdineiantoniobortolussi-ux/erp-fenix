import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_dre_cabecalho_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_dre_cabecalho_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_dre_cabecalho_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_dre_cabecalho_repository.dart';

class ContabilDreCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilDreCabecalhoController>(() => ContabilDreCabecalhoController(
					contabilDreCabecalhoRepository:
							ContabilDreCabecalhoRepository(contabilDreCabecalhoApiProvider: ContabilDreCabecalhoApiProvider(), contabilDreCabecalhoDriftProvider: ContabilDreCabecalhoDriftProvider()))),
		];
	}
}
