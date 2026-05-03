import 'package:get/get.dart';
import 'package:projetos/app/controller/projeto_principal_controller.dart';
import 'package:projetos/app/data/provider/api/projeto_principal_api_provider.dart';
import 'package:projetos/app/data/provider/drift/projeto_principal_drift_provider.dart';
import 'package:projetos/app/data/repository/projeto_principal_repository.dart';

class ProjetoPrincipalBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ProjetoPrincipalController>(() => ProjetoPrincipalController(
					projetoPrincipalRepository:
							ProjetoPrincipalRepository(projetoPrincipalApiProvider: ProjetoPrincipalApiProvider(), projetoPrincipalDriftProvider: ProjetoPrincipalDriftProvider()))),
		];
	}
}
