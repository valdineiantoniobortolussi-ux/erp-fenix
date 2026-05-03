import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_cana_deducoes_safra_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_cana_deducoes_safra_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_cana_deducoes_safra_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_cana_deducoes_safra_repository.dart';

class NfeCanaDeducoesSafraBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeCanaDeducoesSafraController>(() => NfeCanaDeducoesSafraController(
					nfeCanaDeducoesSafraRepository:
							NfeCanaDeducoesSafraRepository(nfeCanaDeducoesSafraApiProvider: NfeCanaDeducoesSafraApiProvider(), nfeCanaDeducoesSafraDriftProvider: NfeCanaDeducoesSafraDriftProvider()))),
		];
	}
}
