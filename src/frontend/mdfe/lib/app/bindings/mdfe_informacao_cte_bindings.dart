import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_informacao_cte_controller.dart';
import 'package:mdfe/app/data/provider/api/mdfe_informacao_cte_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_informacao_cte_drift_provider.dart';
import 'package:mdfe/app/data/repository/mdfe_informacao_cte_repository.dart';

class MdfeInformacaoCteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MdfeInformacaoCteController>(() => MdfeInformacaoCteController(
					mdfeInformacaoCteRepository:
							MdfeInformacaoCteRepository(mdfeInformacaoCteApiProvider: MdfeInformacaoCteApiProvider(), mdfeInformacaoCteDriftProvider: MdfeInformacaoCteDriftProvider()))),
		];
	}
}
