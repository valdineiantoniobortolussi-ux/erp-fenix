import 'package:get/get.dart';
import 'package:cadastros/app/controller/produto_subgrupo_controller.dart';
import 'package:cadastros/app/data/provider/api/produto_subgrupo_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/produto_subgrupo_drift_provider.dart';
import 'package:cadastros/app/data/repository/produto_subgrupo_repository.dart';

class ProdutoSubgrupoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ProdutoSubgrupoController>(() => ProdutoSubgrupoController(
					produtoSubgrupoRepository:
							ProdutoSubgrupoRepository(produtoSubgrupoApiProvider: ProdutoSubgrupoApiProvider(), produtoSubgrupoDriftProvider: ProdutoSubgrupoDriftProvider()))),
		];
	}
}
