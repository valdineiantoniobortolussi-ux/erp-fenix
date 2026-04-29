import 'package:get/get.dart';
import 'package:vendas/app/controller/venda_cabecalho_controller.dart';
import 'package:vendas/app/data/provider/api/venda_cabecalho_api_provider.dart';
import 'package:vendas/app/data/provider/drift/venda_cabecalho_drift_provider.dart';
import 'package:vendas/app/data/repository/venda_cabecalho_repository.dart';

class VendaCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<VendaCabecalhoController>(() => VendaCabecalhoController(
					vendaCabecalhoRepository:
							VendaCabecalhoRepository(vendaCabecalhoApiProvider: VendaCabecalhoApiProvider(), vendaCabecalhoDriftProvider: VendaCabecalhoDriftProvider()))),
		];
	}
}
