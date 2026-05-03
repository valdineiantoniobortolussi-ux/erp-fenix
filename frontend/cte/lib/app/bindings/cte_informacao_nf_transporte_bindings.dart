import 'package:get/get.dart';
import 'package:cte/app/controller/cte_informacao_nf_transporte_controller.dart';
import 'package:cte/app/data/provider/api/cte_informacao_nf_transporte_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_informacao_nf_transporte_drift_provider.dart';
import 'package:cte/app/data/repository/cte_informacao_nf_transporte_repository.dart';

class CteInformacaoNfTransporteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CteInformacaoNfTransporteController>(() => CteInformacaoNfTransporteController(
					cteInformacaoNfTransporteRepository:
							CteInformacaoNfTransporteRepository(cteInformacaoNfTransporteApiProvider: CteInformacaoNfTransporteApiProvider(), cteInformacaoNfTransporteDriftProvider: CteInformacaoNfTransporteDriftProvider()))),
		];
	}
}
