import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_operacao_fiscal_controller.dart';
import 'package:tributacao/app/data/provider/api/tribut_operacao_fiscal_api_provider.dart';
import 'package:tributacao/app/data/provider/drift/tribut_operacao_fiscal_drift_provider.dart';
import 'package:tributacao/app/data/repository/tribut_operacao_fiscal_repository.dart';

class TributOperacaoFiscalBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TributOperacaoFiscalController>(() => TributOperacaoFiscalController(
					tributOperacaoFiscalRepository:
							TributOperacaoFiscalRepository(tributOperacaoFiscalApiProvider: TributOperacaoFiscalApiProvider(), tributOperacaoFiscalDriftProvider: TributOperacaoFiscalDriftProvider()))),
		];
	}
}
