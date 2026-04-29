import 'package:get/get.dart';
import 'package:folha/app/controller/folha_ppp_controller.dart';
import 'package:folha/app/data/provider/api/folha_ppp_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_ppp_drift_provider.dart';
import 'package:folha/app/data/repository/folha_ppp_repository.dart';

class FolhaPppBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaPppController>(() => FolhaPppController(
					folhaPppRepository:
							FolhaPppRepository(folhaPppApiProvider: FolhaPppApiProvider(), folhaPppDriftProvider: FolhaPppDriftProvider()))),
		];
	}
}
