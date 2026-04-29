import 'package:get/get.dart';
import 'package:cadastros/app/controller/produto_unidade_controller.dart';
import 'package:cadastros/app/data/provider/api/produto_unidade_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/produto_unidade_drift_provider.dart';
import 'package:cadastros/app/data/repository/produto_unidade_repository.dart';

class ProdutoUnidadeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ProdutoUnidadeController>(() => ProdutoUnidadeController(
					produtoUnidadeRepository:
							ProdutoUnidadeRepository(produtoUnidadeApiProvider: ProdutoUnidadeApiProvider(), produtoUnidadeDriftProvider: ProdutoUnidadeDriftProvider()))),
		];
	}
}
