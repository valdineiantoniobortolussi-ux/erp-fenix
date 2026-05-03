import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_rodoviario_ciot_controller.dart';
import 'package:mdfe/app/data/provider/api/mdfe_rodoviario_ciot_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_rodoviario_ciot_drift_provider.dart';
import 'package:mdfe/app/data/repository/mdfe_rodoviario_ciot_repository.dart';

class MdfeRodoviarioCiotBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MdfeRodoviarioCiotController>(() => MdfeRodoviarioCiotController(
					mdfeRodoviarioCiotRepository:
							MdfeRodoviarioCiotRepository(mdfeRodoviarioCiotApiProvider: MdfeRodoviarioCiotApiProvider(), mdfeRodoviarioCiotDriftProvider: MdfeRodoviarioCiotDriftProvider()))),
		];
	}
}
