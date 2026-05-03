import 'package:get/get.dart';
import 'package:cadastros/app/controller/banco_agencia_controller.dart';
import 'package:cadastros/app/data/provider/api/banco_agencia_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/banco_agencia_drift_provider.dart';
import 'package:cadastros/app/data/repository/banco_agencia_repository.dart';

class BancoAgenciaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<BancoAgenciaController>(() => BancoAgenciaController(
					bancoAgenciaRepository:
							BancoAgenciaRepository(bancoAgenciaApiProvider: BancoAgenciaApiProvider(), bancoAgenciaDriftProvider: BancoAgenciaDriftProvider()))),
		];
	}
}
