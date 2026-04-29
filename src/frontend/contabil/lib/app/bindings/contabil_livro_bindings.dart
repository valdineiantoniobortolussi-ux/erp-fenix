import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_livro_controller.dart';
import 'package:contabil/app/data/provider/api/contabil_livro_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_livro_drift_provider.dart';
import 'package:contabil/app/data/repository/contabil_livro_repository.dart';

class ContabilLivroBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContabilLivroController>(() => ContabilLivroController(
					contabilLivroRepository:
							ContabilLivroRepository(contabilLivroApiProvider: ContabilLivroApiProvider(), contabilLivroDriftProvider: ContabilLivroDriftProvider()))),
		];
	}
}
