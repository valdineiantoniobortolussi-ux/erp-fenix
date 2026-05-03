import 'package:get/get.dart';
import 'package:compras/app/controller/compra_requisicao_controller.dart';
import 'package:compras/app/data/provider/api/compra_requisicao_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_requisicao_drift_provider.dart';
import 'package:compras/app/data/repository/compra_requisicao_repository.dart';

class CompraRequisicaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CompraRequisicaoController>(() => CompraRequisicaoController(
					compraRequisicaoRepository:
							CompraRequisicaoRepository(compraRequisicaoApiProvider: CompraRequisicaoApiProvider(), compraRequisicaoDriftProvider: CompraRequisicaoDriftProvider()))),
		];
	}
}
