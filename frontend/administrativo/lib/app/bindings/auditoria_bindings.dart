import 'package:get/get.dart';
import 'package:administrativo/app/controller/auditoria_controller.dart';
import 'package:administrativo/app/data/provider/api/auditoria_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/auditoria_drift_provider.dart';
import 'package:administrativo/app/data/repository/auditoria_repository.dart';

class AuditoriaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<AuditoriaController>(() => AuditoriaController(
					repository: AuditoriaRepository(auditoriaApiProvider: AuditoriaApiProvider(), auditoriaDriftProvider: AuditoriaDriftProvider()))),
		];
	}
}
