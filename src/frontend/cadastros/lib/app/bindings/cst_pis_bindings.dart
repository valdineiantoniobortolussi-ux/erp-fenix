import 'package:get/get.dart';
import 'package:cadastros/app/controller/cst_pis_controller.dart';
import 'package:cadastros/app/data/provider/api/cst_pis_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cst_pis_drift_provider.dart';
import 'package:cadastros/app/data/repository/cst_pis_repository.dart';

class CstPisBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CstPisController>(() => CstPisController(
					cstPisRepository:
							CstPisRepository(cstPisApiProvider: CstPisApiProvider(), cstPisDriftProvider: CstPisDriftProvider()))),
		];
	}
}
