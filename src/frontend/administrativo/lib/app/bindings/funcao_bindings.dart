import 'package:get/get.dart';
import 'package:administrativo/app/controller/funcao_controller.dart';
import 'package:administrativo/app/data/provider/api/funcao_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/funcao_drift_provider.dart';
import 'package:administrativo/app/data/repository/funcao_repository.dart';

class FuncaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FuncaoController>(() => FuncaoController(
					repository: FuncaoRepository(funcaoApiProvider: FuncaoApiProvider(), funcaoDriftProvider: FuncaoDriftProvider()))),
		];
	}
}
