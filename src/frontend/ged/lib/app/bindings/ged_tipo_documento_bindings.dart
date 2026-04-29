import 'package:get/get.dart';
import 'package:ged/app/controller/ged_tipo_documento_controller.dart';
import 'package:ged/app/data/provider/api/ged_tipo_documento_api_provider.dart';
import 'package:ged/app/data/provider/drift/ged_tipo_documento_drift_provider.dart';
import 'package:ged/app/data/repository/ged_tipo_documento_repository.dart';

class GedTipoDocumentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<GedTipoDocumentoController>(() => GedTipoDocumentoController(
					gedTipoDocumentoRepository:
							GedTipoDocumentoRepository(gedTipoDocumentoApiProvider: GedTipoDocumentoApiProvider(), gedTipoDocumentoDriftProvider: GedTipoDocumentoDriftProvider()))),
		];
	}
}
