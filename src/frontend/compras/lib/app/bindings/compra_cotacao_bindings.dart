import 'package:get/get.dart';
import 'package:compras/app/controller/compra_cotacao_controller.dart';
import 'package:compras/app/data/provider/api/compra_cotacao_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_cotacao_drift_provider.dart';
import 'package:compras/app/data/repository/compra_cotacao_repository.dart';

class CompraCotacaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CompraCotacaoController>(() => CompraCotacaoController(
					compraCotacaoRepository:
							CompraCotacaoRepository(compraCotacaoApiProvider: CompraCotacaoApiProvider(), compraCotacaoDriftProvider: CompraCotacaoDriftProvider()))),
		];
	}
}
