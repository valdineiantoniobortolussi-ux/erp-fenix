import 'package:get/get.dart';
import 'package:folha/app/controller/folha_lancamento_cabecalho_controller.dart';
import 'package:folha/app/data/provider/api/folha_lancamento_cabecalho_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_lancamento_cabecalho_drift_provider.dart';
import 'package:folha/app/data/repository/folha_lancamento_cabecalho_repository.dart';

class FolhaLancamentoCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaLancamentoCabecalhoController>(() => FolhaLancamentoCabecalhoController(
					folhaLancamentoCabecalhoRepository:
							FolhaLancamentoCabecalhoRepository(folhaLancamentoCabecalhoApiProvider: FolhaLancamentoCabecalhoApiProvider(), folhaLancamentoCabecalhoDriftProvider: FolhaLancamentoCabecalhoDriftProvider()))),
		];
	}
}
