import 'package:get/get.dart';
import 'package:contratos/app/controller/contrato_solicitacao_servico_controller.dart';
import 'package:contratos/app/data/provider/api/contrato_solicitacao_servico_api_provider.dart';
import 'package:contratos/app/data/provider/drift/contrato_solicitacao_servico_drift_provider.dart';
import 'package:contratos/app/data/repository/contrato_solicitacao_servico_repository.dart';

class ContratoSolicitacaoServicoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContratoSolicitacaoServicoController>(() => ContratoSolicitacaoServicoController(
					contratoSolicitacaoServicoRepository:
							ContratoSolicitacaoServicoRepository(contratoSolicitacaoServicoApiProvider: ContratoSolicitacaoServicoApiProvider(), contratoSolicitacaoServicoDriftProvider: ContratoSolicitacaoServicoDriftProvider()))),
		];
	}
}
