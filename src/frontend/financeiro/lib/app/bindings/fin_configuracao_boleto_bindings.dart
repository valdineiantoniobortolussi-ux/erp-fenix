import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_configuracao_boleto_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_configuracao_boleto_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_configuracao_boleto_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_configuracao_boleto_repository.dart';

class FinConfiguracaoBoletoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinConfiguracaoBoletoController>(() => FinConfiguracaoBoletoController(
					finConfiguracaoBoletoRepository:
							FinConfiguracaoBoletoRepository(finConfiguracaoBoletoApiProvider: FinConfiguracaoBoletoApiProvider(), finConfiguracaoBoletoDriftProvider: FinConfiguracaoBoletoDriftProvider()))),
		];
	}
}
