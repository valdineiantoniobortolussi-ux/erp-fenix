import 'package:get/get.dart';
import 'package:estoque/app/controller/estoque_tamanho_controller.dart';
import 'package:estoque/app/data/provider/api/estoque_tamanho_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_tamanho_drift_provider.dart';
import 'package:estoque/app/data/repository/estoque_tamanho_repository.dart';

class EstoqueTamanhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EstoqueTamanhoController>(() => EstoqueTamanhoController(
					estoqueTamanhoRepository:
							EstoqueTamanhoRepository(estoqueTamanhoApiProvider: EstoqueTamanhoApiProvider(), estoqueTamanhoDriftProvider: EstoqueTamanhoDriftProvider()))),
		];
	}
}
