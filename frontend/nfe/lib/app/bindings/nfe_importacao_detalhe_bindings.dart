import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_importacao_detalhe_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_importacao_detalhe_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_importacao_detalhe_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_importacao_detalhe_repository.dart';

class NfeImportacaoDetalheBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeImportacaoDetalheController>(() => NfeImportacaoDetalheController(
					nfeImportacaoDetalheRepository:
							NfeImportacaoDetalheRepository(nfeImportacaoDetalheApiProvider: NfeImportacaoDetalheApiProvider(), nfeImportacaoDetalheDriftProvider: NfeImportacaoDetalheDriftProvider()))),
		];
	}
}
