import 'package:get/get.dart';
import 'package:folha/app/controller/folha_inss_servico_controller.dart';
import 'package:folha/app/data/provider/api/folha_inss_servico_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_inss_servico_drift_provider.dart';
import 'package:folha/app/data/repository/folha_inss_servico_repository.dart';

class FolhaInssServicoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaInssServicoController>(() => FolhaInssServicoController(
					folhaInssServicoRepository:
							FolhaInssServicoRepository(folhaInssServicoApiProvider: FolhaInssServicoApiProvider(), folhaInssServicoDriftProvider: FolhaInssServicoDriftProvider()))),
		];
	}
}
