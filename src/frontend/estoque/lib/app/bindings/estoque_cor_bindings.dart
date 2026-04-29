import 'package:get/get.dart';
import 'package:estoque/app/controller/estoque_cor_controller.dart';
import 'package:estoque/app/data/provider/api/estoque_cor_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_cor_drift_provider.dart';
import 'package:estoque/app/data/repository/estoque_cor_repository.dart';

class EstoqueCorBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EstoqueCorController>(() => EstoqueCorController(
					estoqueCorRepository:
							EstoqueCorRepository(estoqueCorApiProvider: EstoqueCorApiProvider(), estoqueCorDriftProvider: EstoqueCorDriftProvider()))),
		];
	}
}
