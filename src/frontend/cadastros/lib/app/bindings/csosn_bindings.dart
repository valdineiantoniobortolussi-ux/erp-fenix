import 'package:get/get.dart';
import 'package:cadastros/app/controller/csosn_controller.dart';
import 'package:cadastros/app/data/provider/api/csosn_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/csosn_drift_provider.dart';
import 'package:cadastros/app/data/repository/csosn_repository.dart';

class CsosnBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CsosnController>(() => CsosnController(
					csosnRepository:
							CsosnRepository(csosnApiProvider: CsosnApiProvider(), csosnDriftProvider: CsosnDriftProvider()))),
		];
	}
}
