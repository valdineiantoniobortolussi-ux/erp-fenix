import 'package:get/get.dart';
import 'package:compras/app/controller/compra_pedido_controller.dart';
import 'package:compras/app/data/provider/api/compra_pedido_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_pedido_drift_provider.dart';
import 'package:compras/app/data/repository/compra_pedido_repository.dart';

class CompraPedidoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CompraPedidoController>(() => CompraPedidoController(
					compraPedidoRepository:
							CompraPedidoRepository(compraPedidoApiProvider: CompraPedidoApiProvider(), compraPedidoDriftProvider: CompraPedidoDriftProvider()))),
		];
	}
}
