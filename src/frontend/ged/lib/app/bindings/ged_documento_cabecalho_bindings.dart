import 'package:get/get.dart';
import 'package:ged/app/controller/ged_documento_cabecalho_controller.dart';
import 'package:ged/app/data/provider/api/ged_documento_cabecalho_api_provider.dart';
import 'package:ged/app/data/provider/drift/ged_documento_cabecalho_drift_provider.dart';
import 'package:ged/app/data/repository/ged_documento_cabecalho_repository.dart';

class GedDocumentoCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<GedDocumentoCabecalhoController>(() => GedDocumentoCabecalhoController(
					gedDocumentoCabecalhoRepository:
							GedDocumentoCabecalhoRepository(gedDocumentoCabecalhoApiProvider: GedDocumentoCabecalhoApiProvider(), gedDocumentoCabecalhoDriftProvider: GedDocumentoCabecalhoDriftProvider()))),
		];
	}
}
