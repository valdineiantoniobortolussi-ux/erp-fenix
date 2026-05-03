import 'package:get/get.dart';
import 'package:compras/app/controller/compra_tipo_requisicao_controller.dart';
import 'package:compras/app/data/provider/api/compra_tipo_requisicao_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_tipo_requisicao_drift_provider.dart';
import 'package:compras/app/data/repository/compra_tipo_requisicao_repository.dart';

class CompraTipoRequisicaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CompraTipoRequisicaoController>(() => CompraTipoRequisicaoController(
					compraTipoRequisicaoRepository:
							CompraTipoRequisicaoRepository(compraTipoRequisicaoApiProvider: CompraTipoRequisicaoApiProvider(), compraTipoRequisicaoDriftProvider: CompraTipoRequisicaoDriftProvider()))),
		];
	}
}
