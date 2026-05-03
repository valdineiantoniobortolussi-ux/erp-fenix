import 'package:get/get.dart';
import 'package:sped/app/controller/sintegra_controller.dart';
import 'package:sped/app/data/provider/api/sintegra_api_provider.dart';
import 'package:sped/app/data/provider/drift/sintegra_drift_provider.dart';
import 'package:sped/app/data/repository/sintegra_repository.dart';

class SintegraBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<SintegraController>(() => SintegraController(
					sintegraRepository:
							SintegraRepository(sintegraApiProvider: SintegraApiProvider(), sintegraDriftProvider: SintegraDriftProvider()))),
		];
	}
}
