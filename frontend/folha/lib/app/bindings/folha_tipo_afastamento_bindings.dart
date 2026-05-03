import 'package:get/get.dart';
import 'package:folha/app/controller/folha_tipo_afastamento_controller.dart';
import 'package:folha/app/data/provider/api/folha_tipo_afastamento_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_tipo_afastamento_drift_provider.dart';
import 'package:folha/app/data/repository/folha_tipo_afastamento_repository.dart';

class FolhaTipoAfastamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaTipoAfastamentoController>(() => FolhaTipoAfastamentoController(
					folhaTipoAfastamentoRepository:
							FolhaTipoAfastamentoRepository(folhaTipoAfastamentoApiProvider: FolhaTipoAfastamentoApiProvider(), folhaTipoAfastamentoDriftProvider: FolhaTipoAfastamentoDriftProvider()))),
		];
	}
}
