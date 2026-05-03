import 'package:get/get.dart';
import 'package:folha/app/controller/folha_vale_transporte_controller.dart';
import 'package:folha/app/data/provider/api/folha_vale_transporte_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_vale_transporte_drift_provider.dart';
import 'package:folha/app/data/repository/folha_vale_transporte_repository.dart';

class FolhaValeTransporteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaValeTransporteController>(() => FolhaValeTransporteController(
					folhaValeTransporteRepository:
							FolhaValeTransporteRepository(folhaValeTransporteApiProvider: FolhaValeTransporteApiProvider(), folhaValeTransporteDriftProvider: FolhaValeTransporteDriftProvider()))),
		];
	}
}
