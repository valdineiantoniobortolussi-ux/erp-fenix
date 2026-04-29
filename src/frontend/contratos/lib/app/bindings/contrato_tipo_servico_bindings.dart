import 'package:get/get.dart';
import 'package:contratos/app/controller/contrato_tipo_servico_controller.dart';
import 'package:contratos/app/data/provider/api/contrato_tipo_servico_api_provider.dart';
import 'package:contratos/app/data/provider/drift/contrato_tipo_servico_drift_provider.dart';
import 'package:contratos/app/data/repository/contrato_tipo_servico_repository.dart';

class ContratoTipoServicoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContratoTipoServicoController>(() => ContratoTipoServicoController(
					contratoTipoServicoRepository:
							ContratoTipoServicoRepository(contratoTipoServicoApiProvider: ContratoTipoServicoApiProvider(), contratoTipoServicoDriftProvider: ContratoTipoServicoDriftProvider()))),
		];
	}
}
