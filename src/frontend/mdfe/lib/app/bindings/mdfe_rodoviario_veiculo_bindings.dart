import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_rodoviario_veiculo_controller.dart';
import 'package:mdfe/app/data/provider/api/mdfe_rodoviario_veiculo_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_rodoviario_veiculo_drift_provider.dart';
import 'package:mdfe/app/data/repository/mdfe_rodoviario_veiculo_repository.dart';

class MdfeRodoviarioVeiculoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MdfeRodoviarioVeiculoController>(() => MdfeRodoviarioVeiculoController(
					mdfeRodoviarioVeiculoRepository:
							MdfeRodoviarioVeiculoRepository(mdfeRodoviarioVeiculoApiProvider: MdfeRodoviarioVeiculoApiProvider(), mdfeRodoviarioVeiculoDriftProvider: MdfeRodoviarioVeiculoDriftProvider()))),
		];
	}
}
