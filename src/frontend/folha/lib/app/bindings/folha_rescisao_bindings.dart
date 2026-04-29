import 'package:get/get.dart';
import 'package:folha/app/controller/folha_rescisao_controller.dart';
import 'package:folha/app/data/provider/api/folha_rescisao_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_rescisao_drift_provider.dart';
import 'package:folha/app/data/repository/folha_rescisao_repository.dart';

class FolhaRescisaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaRescisaoController>(() => FolhaRescisaoController(
					folhaRescisaoRepository:
							FolhaRescisaoRepository(folhaRescisaoApiProvider: FolhaRescisaoApiProvider(), folhaRescisaoDriftProvider: FolhaRescisaoDriftProvider()))),
		];
	}
}
