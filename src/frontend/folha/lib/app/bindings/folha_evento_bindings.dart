import 'package:get/get.dart';
import 'package:folha/app/controller/folha_evento_controller.dart';
import 'package:folha/app/data/provider/api/folha_evento_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_evento_drift_provider.dart';
import 'package:folha/app/data/repository/folha_evento_repository.dart';

class FolhaEventoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaEventoController>(() => FolhaEventoController(
					folhaEventoRepository:
							FolhaEventoRepository(folhaEventoApiProvider: FolhaEventoApiProvider(), folhaEventoDriftProvider: FolhaEventoDriftProvider()))),
		];
	}
}
