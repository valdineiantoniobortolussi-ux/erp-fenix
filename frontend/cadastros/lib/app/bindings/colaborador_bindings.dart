import 'package:get/get.dart';
import 'package:cadastros/app/controller/colaborador_controller.dart';
import 'package:cadastros/app/data/provider/api/colaborador_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/colaborador_drift_provider.dart';
import 'package:cadastros/app/data/repository/colaborador_repository.dart';

class ColaboradorBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ColaboradorController>(() => ColaboradorController(
					colaboradorRepository:
							ColaboradorRepository(colaboradorApiProvider: ColaboradorApiProvider(), colaboradorDriftProvider: ColaboradorDriftProvider()))),
		];
	}
}
