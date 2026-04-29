import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_nota_fiscal_saida_controller.dart';
import 'package:fiscal/app/data/provider/api/fiscal_nota_fiscal_saida_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_nota_fiscal_saida_drift_provider.dart';
import 'package:fiscal/app/data/repository/fiscal_nota_fiscal_saida_repository.dart';

class FiscalNotaFiscalSaidaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FiscalNotaFiscalSaidaController>(() => FiscalNotaFiscalSaidaController(
					fiscalNotaFiscalSaidaRepository:
							FiscalNotaFiscalSaidaRepository(fiscalNotaFiscalSaidaApiProvider: FiscalNotaFiscalSaidaApiProvider(), fiscalNotaFiscalSaidaDriftProvider: FiscalNotaFiscalSaidaDriftProvider()))),
		];
	}
}
