import 'package:get/get.dart';
import 'package:estoque/app/controller/requisicao_interna_cabecalho_controller.dart';
import 'package:estoque/app/data/provider/api/requisicao_interna_cabecalho_api_provider.dart';
import 'package:estoque/app/data/provider/drift/requisicao_interna_cabecalho_drift_provider.dart';
import 'package:estoque/app/data/repository/requisicao_interna_cabecalho_repository.dart';

class RequisicaoInternaCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<RequisicaoInternaCabecalhoController>(() => RequisicaoInternaCabecalhoController(
					requisicaoInternaCabecalhoRepository:
							RequisicaoInternaCabecalhoRepository(requisicaoInternaCabecalhoApiProvider: RequisicaoInternaCabecalhoApiProvider(), requisicaoInternaCabecalhoDriftProvider: RequisicaoInternaCabecalhoDriftProvider()))),
		];
	}
}
