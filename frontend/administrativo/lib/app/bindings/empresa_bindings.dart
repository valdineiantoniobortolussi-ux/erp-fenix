import 'package:get/get.dart';
import 'package:administrativo/app/controller/empresa_controller.dart';
import 'package:administrativo/app/data/provider/api/empresa_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/empresa_drift_provider.dart';
import 'package:administrativo/app/data/repository/empresa_repository.dart';

class EmpresaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EmpresaController>(() => EmpresaController(
					repository: EmpresaRepository(empresaApiProvider: EmpresaApiProvider(), empresaDriftProvider: EmpresaDriftProvider()))),
		];
	}
}
