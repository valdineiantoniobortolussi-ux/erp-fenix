import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_transporte_volume_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_transporte_volume_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_transporte_volume_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_transporte_volume_repository.dart';

class NfeTransporteVolumeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeTransporteVolumeController>(() => NfeTransporteVolumeController(
					nfeTransporteVolumeRepository:
							NfeTransporteVolumeRepository(nfeTransporteVolumeApiProvider: NfeTransporteVolumeApiProvider(), nfeTransporteVolumeDriftProvider: NfeTransporteVolumeDriftProvider()))),
		];
	}
}
