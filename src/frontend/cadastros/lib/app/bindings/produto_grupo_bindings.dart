import 'package:get/get.dart';
import 'package:cadastros/app/controller/produto_grupo_controller.dart';
import 'package:cadastros/app/data/provider/api/produto_grupo_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/produto_grupo_drift_provider.dart';
import 'package:cadastros/app/data/repository/produto_grupo_repository.dart';

class ProdutoGrupoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ProdutoGrupoController>(() => ProdutoGrupoController(
					produtoGrupoRepository:
							ProdutoGrupoRepository(produtoGrupoApiProvider: ProdutoGrupoApiProvider(), produtoGrupoDriftProvider: ProdutoGrupoDriftProvider()))),
		];
	}
}
