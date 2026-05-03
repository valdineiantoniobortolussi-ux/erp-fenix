import 'package:get/get.dart';
import 'package:comissoes/app/controller/comissao_objetivo_controller.dart';
import 'package:comissoes/app/data/provider/api/comissao_objetivo_api_provider.dart';
import 'package:comissoes/app/data/provider/drift/comissao_objetivo_drift_provider.dart';
import 'package:comissoes/app/data/repository/comissao_objetivo_repository.dart';

class ComissaoObjetivoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ComissaoObjetivoController>(() => ComissaoObjetivoController(
					comissaoObjetivoRepository:
							ComissaoObjetivoRepository(comissaoObjetivoApiProvider: ComissaoObjetivoApiProvider(), comissaoObjetivoDriftProvider: ComissaoObjetivoDriftProvider()))),
		];
	}
}
