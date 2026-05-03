import 'package:get/get.dart';
import 'package:cadastros/app/controller/produto_marca_controller.dart';
import 'package:cadastros/app/data/provider/api/produto_marca_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/produto_marca_drift_provider.dart';
import 'package:cadastros/app/data/repository/produto_marca_repository.dart';

class ProdutoMarcaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ProdutoMarcaController>(() => ProdutoMarcaController(
					produtoMarcaRepository:
							ProdutoMarcaRepository(produtoMarcaApiProvider: ProdutoMarcaApiProvider(), produtoMarcaDriftProvider: ProdutoMarcaDriftProvider()))),
		];
	}
}
