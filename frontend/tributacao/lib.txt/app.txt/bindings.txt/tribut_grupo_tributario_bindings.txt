import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_grupo_tributario_controller.dart';
import 'package:tributacao/app/data/provider/api/tribut_grupo_tributario_api_provider.dart';
import 'package:tributacao/app/data/provider/drift/tribut_grupo_tributario_drift_provider.dart';
import 'package:tributacao/app/data/repository/tribut_grupo_tributario_repository.dart';

class TributGrupoTributarioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TributGrupoTributarioController>(() => TributGrupoTributarioController(
					tributGrupoTributarioRepository:
							TributGrupoTributarioRepository(tributGrupoTributarioApiProvider: TributGrupoTributarioApiProvider(), tributGrupoTributarioDriftProvider: TributGrupoTributarioDriftProvider()))),
		];
	}
}
