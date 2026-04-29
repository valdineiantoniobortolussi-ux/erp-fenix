import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_livro_controller.dart';
import 'package:fiscal/app/data/provider/api/fiscal_livro_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_livro_drift_provider.dart';
import 'package:fiscal/app/data/repository/fiscal_livro_repository.dart';

class FiscalLivroBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FiscalLivroController>(() => FiscalLivroController(
					fiscalLivroRepository:
							FiscalLivroRepository(fiscalLivroApiProvider: FiscalLivroApiProvider(), fiscalLivroDriftProvider: FiscalLivroDriftProvider()))),
		];
	}
}
