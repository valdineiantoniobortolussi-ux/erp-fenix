import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_duplicata_controller.dart';
import 'package:nfe/app/data/provider/api/nfe_duplicata_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_duplicata_drift_provider.dart';
import 'package:nfe/app/data/repository/nfe_duplicata_repository.dart';

class NfeDuplicataBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NfeDuplicataController>(() => NfeDuplicataController(
					nfeDuplicataRepository:
							NfeDuplicataRepository(nfeDuplicataApiProvider: NfeDuplicataApiProvider(), nfeDuplicataDriftProvider: NfeDuplicataDriftProvider()))),
		];
	}
}
