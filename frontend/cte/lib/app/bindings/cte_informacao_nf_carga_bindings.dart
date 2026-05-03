import 'package:get/get.dart';
import 'package:cte/app/controller/cte_informacao_nf_carga_controller.dart';
import 'package:cte/app/data/provider/api/cte_informacao_nf_carga_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_informacao_nf_carga_drift_provider.dart';
import 'package:cte/app/data/repository/cte_informacao_nf_carga_repository.dart';

class CteInformacaoNfCargaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteInformacaoNfCargaController>(() => CteInformacaoNfCargaController(
					cteInformacaoNfCargaRepository:
							CteInformacaoNfCargaRepository(cteInformacaoNfCargaApiProvider: CteInformacaoNfCargaApiProvider(), cteInformacaoNfCargaDriftProvider: CteInformacaoNfCargaDriftProvider()))),
		];
	}
}
