import 'package:get/get.dart';
import 'package:frotas/app/controller/frota_motorista_controller.dart';
import 'package:frotas/app/data/provider/api/frota_motorista_api_provider.dart';
import 'package:frotas/app/data/provider/drift/frota_motorista_drift_provider.dart';
import 'package:frotas/app/data/repository/frota_motorista_repository.dart';

class FrotaMotoristaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FrotaMotoristaController>(() => FrotaMotoristaController(
					frotaMotoristaRepository:
							FrotaMotoristaRepository(frotaMotoristaApiProvider: FrotaMotoristaApiProvider(), frotaMotoristaDriftProvider: FrotaMotoristaDriftProvider()))),
		];
	}
}
