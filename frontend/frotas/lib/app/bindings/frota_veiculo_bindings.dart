import 'package:get/get.dart';
import 'package:frotas/app/controller/frota_veiculo_controller.dart';
import 'package:frotas/app/data/provider/api/frota_veiculo_api_provider.dart';
import 'package:frotas/app/data/provider/drift/frota_veiculo_drift_provider.dart';
import 'package:frotas/app/data/repository/frota_veiculo_repository.dart';

class FrotaVeiculoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FrotaVeiculoController>(() => FrotaVeiculoController(
					frotaVeiculoRepository:
							FrotaVeiculoRepository(frotaVeiculoApiProvider: FrotaVeiculoApiProvider(), frotaVeiculoDriftProvider: FrotaVeiculoDriftProvider()))),
		];
	}
}
