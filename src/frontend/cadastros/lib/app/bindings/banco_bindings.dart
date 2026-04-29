import 'package:get/get.dart';
import 'package:cadastros/app/controller/banco_controller.dart';
import 'package:cadastros/app/data/provider/api/banco_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/banco_drift_provider.dart';
import 'package:cadastros/app/data/repository/banco_repository.dart';

class BancoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<BancoController>(() => BancoController(
					bancoRepository:
							BancoRepository(bancoApiProvider: BancoApiProvider(), bancoDriftProvider: BancoDriftProvider()))),
		];
	}
}
