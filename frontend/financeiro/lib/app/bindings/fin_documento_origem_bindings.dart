import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_documento_origem_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_documento_origem_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_documento_origem_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_documento_origem_repository.dart';

class FinDocumentoOrigemBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinDocumentoOrigemController>(() => FinDocumentoOrigemController(
					finDocumentoOrigemRepository:
							FinDocumentoOrigemRepository(finDocumentoOrigemApiProvider: FinDocumentoOrigemApiProvider(), finDocumentoOrigemDriftProvider: FinDocumentoOrigemDriftProvider()))),
		];
	}
}
