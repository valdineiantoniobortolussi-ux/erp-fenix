import 'package:get/get.dart';
import 'package:folha/app/controller/guias_acumuladas_controller.dart';
import 'package:folha/app/data/provider/api/guias_acumuladas_api_provider.dart';
import 'package:folha/app/data/provider/drift/guias_acumuladas_drift_provider.dart';
import 'package:folha/app/data/repository/guias_acumuladas_repository.dart';

class GuiasAcumuladasBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<GuiasAcumuladasController>(() => GuiasAcumuladasController(
					guiasAcumuladasRepository:
							GuiasAcumuladasRepository(guiasAcumuladasApiProvider: GuiasAcumuladasApiProvider(), guiasAcumuladasDriftProvider: GuiasAcumuladasDriftProvider()))),
		];
	}
}
