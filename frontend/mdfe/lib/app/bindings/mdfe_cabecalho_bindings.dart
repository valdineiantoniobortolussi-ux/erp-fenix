import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_cabecalho_controller.dart';
import 'package:mdfe/app/data/provider/api/mdfe_cabecalho_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_cabecalho_drift_provider.dart';
import 'package:mdfe/app/data/repository/mdfe_cabecalho_repository.dart';

class MdfeCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MdfeCabecalhoController>(() => MdfeCabecalhoController(
					mdfeCabecalhoRepository:
							MdfeCabecalhoRepository(mdfeCabecalhoApiProvider: MdfeCabecalhoApiProvider(), mdfeCabecalhoDriftProvider: MdfeCabecalhoDriftProvider()))),
		];
	}
}
