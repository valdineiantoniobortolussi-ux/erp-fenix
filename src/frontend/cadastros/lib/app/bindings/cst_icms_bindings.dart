import 'package:get/get.dart';
import 'package:cadastros/app/controller/cst_icms_controller.dart';
import 'package:cadastros/app/data/provider/api/cst_icms_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cst_icms_drift_provider.dart';
import 'package:cadastros/app/data/repository/cst_icms_repository.dart';

class CstIcmsBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CstIcmsController>(() => CstIcmsController(
					cstIcmsRepository:
							CstIcmsRepository(cstIcmsApiProvider: CstIcmsApiProvider(), cstIcmsDriftProvider: CstIcmsDriftProvider()))),
		];
	}
}
