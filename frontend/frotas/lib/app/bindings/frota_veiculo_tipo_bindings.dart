import 'package:get/get.dart';
import 'package:frotas/app/controller/frota_veiculo_tipo_controller.dart';
import 'package:frotas/app/data/provider/api/frota_veiculo_tipo_api_provider.dart';
import 'package:frotas/app/data/provider/drift/frota_veiculo_tipo_drift_provider.dart';
import 'package:frotas/app/data/repository/frota_veiculo_tipo_repository.dart';

class FrotaVeiculoTipoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FrotaVeiculoTipoController>(() => FrotaVeiculoTipoController(
					frotaVeiculoTipoRepository:
							FrotaVeiculoTipoRepository(frotaVeiculoTipoApiProvider: FrotaVeiculoTipoApiProvider(), frotaVeiculoTipoDriftProvider: FrotaVeiculoTipoDriftProvider()))),
		];
	}
}
