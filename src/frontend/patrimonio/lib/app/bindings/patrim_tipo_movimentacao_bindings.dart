import 'package:get/get.dart';
import 'package:patrimonio/app/controller/patrim_tipo_movimentacao_controller.dart';
import 'package:patrimonio/app/data/provider/api/patrim_tipo_movimentacao_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_tipo_movimentacao_drift_provider.dart';
import 'package:patrimonio/app/data/repository/patrim_tipo_movimentacao_repository.dart';

class PatrimTipoMovimentacaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PatrimTipoMovimentacaoController>(() => PatrimTipoMovimentacaoController(
					patrimTipoMovimentacaoRepository:
							PatrimTipoMovimentacaoRepository(patrimTipoMovimentacaoApiProvider: PatrimTipoMovimentacaoApiProvider(), patrimTipoMovimentacaoDriftProvider: PatrimTipoMovimentacaoDriftProvider()))),
		];
	}
}
