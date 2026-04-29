import 'package:get/get.dart';
import 'package:cadastros/app/controller/produto_controller.dart';
import 'package:cadastros/app/data/provider/api/produto_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/produto_drift_provider.dart';
import 'package:cadastros/app/data/repository/produto_repository.dart';

class ProdutoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ProdutoController>(() => ProdutoController(
					produtoRepository:
							ProdutoRepository(produtoApiProvider: ProdutoApiProvider(), produtoDriftProvider: ProdutoDriftProvider()))),
		];
	}
}
