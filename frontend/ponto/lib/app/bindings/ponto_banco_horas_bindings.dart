import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_banco_horas_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_banco_horas_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_banco_horas_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_banco_horas_repository.dart';

class PontoBancoHorasBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoBancoHorasController>(() => PontoBancoHorasController(
					pontoBancoHorasRepository:
							PontoBancoHorasRepository(pontoBancoHorasApiProvider: PontoBancoHorasApiProvider(), pontoBancoHorasDriftProvider: PontoBancoHorasDriftProvider()))),
		];
	}
}
