import 'package:get/get.dart';
import 'package:sped/app/controller/efd_reinf_controller.dart';
import 'package:sped/app/data/provider/api/efd_reinf_api_provider.dart';
import 'package:sped/app/data/provider/drift/efd_reinf_drift_provider.dart';
import 'package:sped/app/data/repository/efd_reinf_repository.dart';

class EfdReinfBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EfdReinfController>(() => EfdReinfController(
					efdReinfRepository:
							EfdReinfRepository(efdReinfApiProvider: EfdReinfApiProvider(), efdReinfDriftProvider: EfdReinfDriftProvider()))),
		];
	}
}
