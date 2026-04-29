import 'package:get/get.dart';
import 'package:ged/app/controller/ged_versao_documento_controller.dart';
import 'package:ged/app/data/provider/api/ged_versao_documento_api_provider.dart';
import 'package:ged/app/data/provider/drift/ged_versao_documento_drift_provider.dart';
import 'package:ged/app/data/repository/ged_versao_documento_repository.dart';

class GedVersaoDocumentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<GedVersaoDocumentoController>(() => GedVersaoDocumentoController(
					gedVersaoDocumentoRepository:
							GedVersaoDocumentoRepository(gedVersaoDocumentoApiProvider: GedVersaoDocumentoApiProvider(), gedVersaoDocumentoDriftProvider: GedVersaoDocumentoDriftProvider()))),
		];
	}
}
