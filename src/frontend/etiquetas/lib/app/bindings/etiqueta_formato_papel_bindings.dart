import 'package:get/get.dart';
import 'package:etiquetas/app/controller/etiqueta_formato_papel_controller.dart';
import 'package:etiquetas/app/data/provider/api/etiqueta_formato_papel_api_provider.dart';
import 'package:etiquetas/app/data/provider/drift/etiqueta_formato_papel_drift_provider.dart';
import 'package:etiquetas/app/data/repository/etiqueta_formato_papel_repository.dart';

class EtiquetaFormatoPapelBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EtiquetaFormatoPapelController>(() => EtiquetaFormatoPapelController(
					etiquetaFormatoPapelRepository:
							EtiquetaFormatoPapelRepository(etiquetaFormatoPapelApiProvider: EtiquetaFormatoPapelApiProvider(), etiquetaFormatoPapelDriftProvider: EtiquetaFormatoPapelDriftProvider()))),
		];
	}
}
