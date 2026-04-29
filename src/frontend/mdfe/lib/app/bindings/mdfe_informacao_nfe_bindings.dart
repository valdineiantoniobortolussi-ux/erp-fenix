import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_informacao_nfe_controller.dart';
import 'package:mdfe/app/data/provider/api/mdfe_informacao_nfe_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_informacao_nfe_drift_provider.dart';
import 'package:mdfe/app/data/repository/mdfe_informacao_nfe_repository.dart';

class MdfeInformacaoNfeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MdfeInformacaoNfeController>(() => MdfeInformacaoNfeController(
					mdfeInformacaoNfeRepository:
							MdfeInformacaoNfeRepository(mdfeInformacaoNfeApiProvider: MdfeInformacaoNfeApiProvider(), mdfeInformacaoNfeDriftProvider: MdfeInformacaoNfeDriftProvider()))),
		];
	}
}
