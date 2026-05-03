import 'package:get/get.dart';
import 'package:cadastros/app/controller/colaborador_tipo_controller.dart';
import 'package:cadastros/app/data/provider/api/colaborador_tipo_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/colaborador_tipo_drift_provider.dart';
import 'package:cadastros/app/data/repository/colaborador_tipo_repository.dart';

class ColaboradorTipoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ColaboradorTipoController>(() => ColaboradorTipoController(
					colaboradorTipoRepository:
							ColaboradorTipoRepository(colaboradorTipoApiProvider: ColaboradorTipoApiProvider(), colaboradorTipoDriftProvider: ColaboradorTipoDriftProvider()))),
		];
	}
}
