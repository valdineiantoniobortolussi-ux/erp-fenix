import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_transporte_reboque_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_transporte_reboque_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_transporte_reboque_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_transporte_reboque_repository.dart';

class NfeTransporteReboqueBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeTransporteReboqueController>(() => NfeTransporteReboqueController(
					nfeTransporteReboqueRepository:
							NfeTransporteReboqueRepository(nfeTransporteReboqueApiProvider: NfeTransporteReboqueApiProvider(), nfeTransporteReboqueDriftProvider: NfeTransporteReboqueDriftProvider()))),
		];
	}
}
