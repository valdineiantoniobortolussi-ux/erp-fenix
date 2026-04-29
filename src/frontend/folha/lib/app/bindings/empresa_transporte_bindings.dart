import 'package:get/get.dart';
import 'package:folha/app/controller/empresa_transporte_controller.dart';
import 'package:folha/app/data/provider/api/empresa_transporte_api_provider.dart';
import 'package:folha/app/data/provider/drift/empresa_transporte_drift_provider.dart';
import 'package:folha/app/data/repository/empresa_transporte_repository.dart';

class EmpresaTransporteBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EmpresaTransporteController>(() => EmpresaTransporteController(
					empresaTransporteRepository:
							EmpresaTransporteRepository(empresaTransporteApiProvider: EmpresaTransporteApiProvider(), empresaTransporteDriftProvider: EmpresaTransporteDriftProvider()))),
		];
	}
}
