import 'package:get/get.dart';
import 'package:inventario/app/controller/inventario_ajuste_cab_controller.dart';
import 'package:inventario/app/data/provider/api/inventario_ajuste_cab_api_provider.dart';
import 'package:inventario/app/data/provider/drift/inventario_ajuste_cab_drift_provider.dart';
import 'package:inventario/app/data/repository/inventario_ajuste_cab_repository.dart';

class InventarioAjusteCabBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<InventarioAjusteCabController>(() => InventarioAjusteCabController(
					inventarioAjusteCabRepository:
							InventarioAjusteCabRepository(inventarioAjusteCabApiProvider: InventarioAjusteCabApiProvider(), inventarioAjusteCabDriftProvider: InventarioAjusteCabDriftProvider()))),
		];
	}
}
