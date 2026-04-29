import 'package:get/get.dart';
import 'package:cadastros/app/controller/cfop_controller.dart';
import 'package:cadastros/app/data/provider/api/cfop_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cfop_drift_provider.dart';
import 'package:cadastros/app/data/repository/cfop_repository.dart';

class CfopBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CfopController>(() => CfopController(
					cfopRepository:
							CfopRepository(cfopApiProvider: CfopApiProvider(), cfopDriftProvider: CfopDriftProvider()))),
		];
	}
}
