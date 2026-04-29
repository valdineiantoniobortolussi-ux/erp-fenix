import 'package:get/get.dart';
import 'package:contratos/app/controller/tipo_contrato_controller.dart';
import 'package:contratos/app/data/provider/api/tipo_contrato_api_provider.dart';
import 'package:contratos/app/data/provider/drift/tipo_contrato_drift_provider.dart';
import 'package:contratos/app/data/repository/tipo_contrato_repository.dart';

class TipoContratoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TipoContratoController>(() => TipoContratoController(
					tipoContratoRepository:
							TipoContratoRepository(tipoContratoApiProvider: TipoContratoApiProvider(), tipoContratoDriftProvider: TipoContratoDriftProvider()))),
		];
	}
}
