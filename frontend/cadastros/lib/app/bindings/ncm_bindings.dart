import 'package:get/get.dart';
import 'package:cadastros/app/controller/ncm_controller.dart';
import 'package:cadastros/app/data/provider/api/ncm_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/ncm_drift_provider.dart';
import 'package:cadastros/app/data/repository/ncm_repository.dart';

class NcmBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NcmController>(() => NcmController(
					ncmRepository:
							NcmRepository(ncmApiProvider: NcmApiProvider(), ncmDriftProvider: NcmDriftProvider()))),
		];
	}
}
