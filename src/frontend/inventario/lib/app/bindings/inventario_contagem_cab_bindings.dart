import 'package:get/get.dart';
import 'package:inventario/app/controller/inventario_contagem_cab_controller.dart';
import 'package:inventario/app/data/provider/api/inventario_contagem_cab_api_provider.dart';
import 'package:inventario/app/data/provider/drift/inventario_contagem_cab_drift_provider.dart';
import 'package:inventario/app/data/repository/inventario_contagem_cab_repository.dart';

class InventarioContagemCabBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<InventarioContagemCabController>(() => InventarioContagemCabController(
					inventarioContagemCabRepository:
							InventarioContagemCabRepository(inventarioContagemCabApiProvider: InventarioContagemCabApiProvider(), inventarioContagemCabDriftProvider: InventarioContagemCabDriftProvider()))),
		];
	}
}
