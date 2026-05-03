import 'package:get/get.dart';
import 'package:etiquetas/app/controller/etiqueta_layout_controller.dart';
import 'package:etiquetas/app/data/provider/api/etiqueta_layout_api_provider.dart';
import 'package:etiquetas/app/data/provider/drift/etiqueta_layout_drift_provider.dart';
import 'package:etiquetas/app/data/repository/etiqueta_layout_repository.dart';

class EtiquetaLayoutBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EtiquetaLayoutController>(() => EtiquetaLayoutController(
					etiquetaLayoutRepository:
							EtiquetaLayoutRepository(etiquetaLayoutApiProvider: EtiquetaLayoutApiProvider(), etiquetaLayoutDriftProvider: EtiquetaLayoutDriftProvider()))),
		];
	}
}
