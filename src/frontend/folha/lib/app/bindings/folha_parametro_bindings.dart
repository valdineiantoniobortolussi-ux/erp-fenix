import 'package:get/get.dart';
import 'package:folha/app/controller/folha_parametro_controller.dart';
import 'package:folha/app/data/provider/api/folha_parametro_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_parametro_drift_provider.dart';
import 'package:folha/app/data/repository/folha_parametro_repository.dart';

class FolhaParametroBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaParametroController>(() => FolhaParametroController(
					folhaParametroRepository:
							FolhaParametroRepository(folhaParametroApiProvider: FolhaParametroApiProvider(), folhaParametroDriftProvider: FolhaParametroDriftProvider()))),
		];
	}
}
