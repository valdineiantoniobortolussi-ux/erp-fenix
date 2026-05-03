import 'package:get/get.dart';
import 'package:patrimonio/app/controller/seguradora_controller.dart';
import 'package:patrimonio/app/data/provider/api/seguradora_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/seguradora_drift_provider.dart';
import 'package:patrimonio/app/data/repository/seguradora_repository.dart';

class SeguradoraBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<SeguradoraController>(() => SeguradoraController(
					seguradoraRepository:
							SeguradoraRepository(seguradoraApiProvider: SeguradoraApiProvider(), seguradoraDriftProvider: SeguradoraDriftProvider()))),
		];
	}
}
