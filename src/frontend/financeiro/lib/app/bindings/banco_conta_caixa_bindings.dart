import 'package:get/get.dart';
import 'package:financeiro/app/controller/banco_conta_caixa_controller.dart';
import 'package:financeiro/app/data/provider/api/banco_conta_caixa_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/banco_conta_caixa_drift_provider.dart';
import 'package:financeiro/app/data/repository/banco_conta_caixa_repository.dart';

class BancoContaCaixaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<BancoContaCaixaController>(() => BancoContaCaixaController(
					bancoContaCaixaRepository:
							BancoContaCaixaRepository(bancoContaCaixaApiProvider: BancoContaCaixaApiProvider(), bancoContaCaixaDriftProvider: BancoContaCaixaDriftProvider()))),
		];
	}
}
