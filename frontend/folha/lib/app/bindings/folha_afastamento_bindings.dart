import 'package:get/get.dart';
import 'package:folha/app/controller/folha_afastamento_controller.dart';
import 'package:folha/app/data/provider/api/folha_afastamento_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_afastamento_drift_provider.dart';
import 'package:folha/app/data/repository/folha_afastamento_repository.dart';

class FolhaAfastamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FolhaAfastamentoController>(() => FolhaAfastamentoController(
					folhaAfastamentoRepository:
							FolhaAfastamentoRepository(folhaAfastamentoApiProvider: FolhaAfastamentoApiProvider(), folhaAfastamentoDriftProvider: FolhaAfastamentoDriftProvider()))),
		];
	}
}
