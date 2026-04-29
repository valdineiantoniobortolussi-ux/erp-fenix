import 'package:get/get.dart';
import 'package:cadastros/app/controller/cargo_controller.dart';
import 'package:cadastros/app/data/provider/api/cargo_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cargo_drift_provider.dart';
import 'package:cadastros/app/data/repository/cargo_repository.dart';

class CargoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CargoController>(() => CargoController(
					cargoRepository:
							CargoRepository(cargoApiProvider: CargoApiProvider(), cargoDriftProvider: CargoDriftProvider()))),
		];
	}
}
