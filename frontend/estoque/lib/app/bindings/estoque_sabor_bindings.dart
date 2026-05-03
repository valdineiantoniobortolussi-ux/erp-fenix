import 'package:get/get.dart';
import 'package:estoque/app/controller/estoque_sabor_controller.dart';
import 'package:estoque/app/data/provider/api/estoque_sabor_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_sabor_drift_provider.dart';
import 'package:estoque/app/data/repository/estoque_sabor_repository.dart';

class EstoqueSaborBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EstoqueSaborController>(() => EstoqueSaborController(
					estoqueSaborRepository:
							EstoqueSaborRepository(estoqueSaborApiProvider: EstoqueSaborApiProvider(), estoqueSaborDriftProvider: EstoqueSaborDriftProvider()))),
		];
	}
}
