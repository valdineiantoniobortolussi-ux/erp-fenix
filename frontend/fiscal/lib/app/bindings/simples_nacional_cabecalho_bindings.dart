import 'package:get/get.dart';
import 'package:fiscal/app/controller/simples_nacional_cabecalho_controller.dart';
import 'package:fiscal/app/data/provider/api/simples_nacional_cabecalho_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/simples_nacional_cabecalho_drift_provider.dart';
import 'package:fiscal/app/data/repository/simples_nacional_cabecalho_repository.dart';

class SimplesNacionalCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<SimplesNacionalCabecalhoController>(() => SimplesNacionalCabecalhoController(
					simplesNacionalCabecalhoRepository:
							SimplesNacionalCabecalhoRepository(simplesNacionalCabecalhoApiProvider: SimplesNacionalCabecalhoApiProvider(), simplesNacionalCabecalhoDriftProvider: SimplesNacionalCabecalhoDriftProvider()))),
		];
	}
}
