import 'package:get/get.dart';
import 'package:compras/app/controller/compra_tipo_pedido_controller.dart';
import 'package:compras/app/data/provider/api/compra_tipo_pedido_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_tipo_pedido_drift_provider.dart';
import 'package:compras/app/data/repository/compra_tipo_pedido_repository.dart';

class CompraTipoPedidoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CompraTipoPedidoController>(() => CompraTipoPedidoController(
					compraTipoPedidoRepository:
							CompraTipoPedidoRepository(compraTipoPedidoApiProvider: CompraTipoPedidoApiProvider(), compraTipoPedidoDriftProvider: CompraTipoPedidoDriftProvider()))),
		];
	}
}
