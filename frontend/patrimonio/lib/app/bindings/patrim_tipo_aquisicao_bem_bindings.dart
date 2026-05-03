import 'package:get/get.dart';
import 'package:patrimonio/app/controller/patrim_tipo_aquisicao_bem_controller.dart';
import 'package:patrimonio/app/data/provider/api/patrim_tipo_aquisicao_bem_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_tipo_aquisicao_bem_drift_provider.dart';
import 'package:patrimonio/app/data/repository/patrim_tipo_aquisicao_bem_repository.dart';

class PatrimTipoAquisicaoBemBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PatrimTipoAquisicaoBemController>(() => PatrimTipoAquisicaoBemController(
					patrimTipoAquisicaoBemRepository:
							PatrimTipoAquisicaoBemRepository(patrimTipoAquisicaoBemApiProvider: PatrimTipoAquisicaoBemApiProvider(), patrimTipoAquisicaoBemDriftProvider: PatrimTipoAquisicaoBemDriftProvider()))),
		];
	}
}
