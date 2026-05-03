import 'package:get/get.dart';
import 'package:comissoes/app/controller/comissao_perfil_controller.dart';
import 'package:comissoes/app/data/provider/api/comissao_perfil_api_provider.dart';
import 'package:comissoes/app/data/provider/drift/comissao_perfil_drift_provider.dart';
import 'package:comissoes/app/data/repository/comissao_perfil_repository.dart';

class ComissaoPerfilBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ComissaoPerfilController>(() => ComissaoPerfilController(
					comissaoPerfilRepository:
							ComissaoPerfilRepository(comissaoPerfilApiProvider: ComissaoPerfilApiProvider(), comissaoPerfilDriftProvider: ComissaoPerfilDriftProvider()))),
		];
	}
}
