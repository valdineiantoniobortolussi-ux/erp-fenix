import 'package:get/get.dart';
import 'package:estoque/app/controller/estoque_marca_controller.dart';
import 'package:estoque/app/data/provider/api/estoque_marca_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_marca_drift_provider.dart';
import 'package:estoque/app/data/repository/estoque_marca_repository.dart';

class EstoqueMarcaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EstoqueMarcaController>(() => EstoqueMarcaController(
					estoqueMarcaRepository:
							EstoqueMarcaRepository(estoqueMarcaApiProvider: EstoqueMarcaApiProvider(), estoqueMarcaDriftProvider: EstoqueMarcaDriftProvider()))),
		];
	}
}
