import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_transporte_volume_lacre_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_transporte_volume_lacre_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_transporte_volume_lacre_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_transporte_volume_lacre_repository.dart';

class NfeTransporteVolumeLacreBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeTransporteVolumeLacreController>(() => NfeTransporteVolumeLacreController(
					nfeTransporteVolumeLacreRepository:
							NfeTransporteVolumeLacreRepository(nfeTransporteVolumeLacreApiProvider: NfeTransporteVolumeLacreApiProvider(), nfeTransporteVolumeLacreDriftProvider: NfeTransporteVolumeLacreDriftProvider()))),
		];
	}
}
