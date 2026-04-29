import 'package:get/get.dart';
import 'package:folha/app/controller/folha_lancamento_comissao_controller.dart';
import 'package:folha/app/data/provider/api/folha_lancamento_comissao_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_lancamento_comissao_drift_provider.dart';
import 'package:folha/app/data/repository/folha_lancamento_comissao_repository.dart';

class FolhaLancamentoComissaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaLancamentoComissaoController>(() => FolhaLancamentoComissaoController(
					folhaLancamentoComissaoRepository:
							FolhaLancamentoComissaoRepository(folhaLancamentoComissaoApiProvider: FolhaLancamentoComissaoApiProvider(), folhaLancamentoComissaoDriftProvider: FolhaLancamentoComissaoDriftProvider()))),
		];
	}
}
