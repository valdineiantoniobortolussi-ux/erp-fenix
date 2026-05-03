import 'package:get/get.dart';
import 'package:cadastros/app/controller/tipo_relacionamento_controller.dart';
import 'package:cadastros/app/data/provider/api/tipo_relacionamento_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/tipo_relacionamento_drift_provider.dart';
import 'package:cadastros/app/data/repository/tipo_relacionamento_repository.dart';

class TipoRelacionamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TipoRelacionamentoController>(() => TipoRelacionamentoController(
					tipoRelacionamentoRepository:
							TipoRelacionamentoRepository(tipoRelacionamentoApiProvider: TipoRelacionamentoApiProvider(), tipoRelacionamentoDriftProvider: TipoRelacionamentoDriftProvider()))),
		];
	}
}
