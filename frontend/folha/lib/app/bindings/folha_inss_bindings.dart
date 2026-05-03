import 'package:get/get.dart';
import 'package:folha/app/controller/folha_inss_controller.dart';
import 'package:folha/app/data/provider/api/folha_inss_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_inss_drift_provider.dart';
import 'package:folha/app/data/repository/folha_inss_repository.dart';

class FolhaInssBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaInssController>(() => FolhaInssController(
					folhaInssRepository:
							FolhaInssRepository(folhaInssApiProvider: FolhaInssApiProvider(), folhaInssDriftProvider: FolhaInssDriftProvider()))),
		];
	}
}
