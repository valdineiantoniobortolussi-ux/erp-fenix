import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_rodoviario_motorista_controller.dart';
import 'package:mdfe/app/data/provider/api/mdfe_rodoviario_motorista_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_rodoviario_motorista_drift_provider.dart';
import 'package:mdfe/app/data/repository/mdfe_rodoviario_motorista_repository.dart';

class MdfeRodoviarioMotoristaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MdfeRodoviarioMotoristaController>(() => MdfeRodoviarioMotoristaController(
					mdfeRodoviarioMotoristaRepository:
							MdfeRodoviarioMotoristaRepository(mdfeRodoviarioMotoristaApiProvider: MdfeRodoviarioMotoristaApiProvider(), mdfeRodoviarioMotoristaDriftProvider: MdfeRodoviarioMotoristaDriftProvider()))),
		];
	}
}
