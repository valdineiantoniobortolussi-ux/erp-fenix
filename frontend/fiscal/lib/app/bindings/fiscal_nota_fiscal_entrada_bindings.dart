import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_nota_fiscal_entrada_controller.dart';
import 'package:fiscal/app/data/provider/api/fiscal_nota_fiscal_entrada_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_nota_fiscal_entrada_drift_provider.dart';
import 'package:fiscal/app/data/repository/fiscal_nota_fiscal_entrada_repository.dart';

class FiscalNotaFiscalEntradaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FiscalNotaFiscalEntradaController>(() => FiscalNotaFiscalEntradaController(
					fiscalNotaFiscalEntradaRepository:
							FiscalNotaFiscalEntradaRepository(fiscalNotaFiscalEntradaApiProvider: FiscalNotaFiscalEntradaApiProvider(), fiscalNotaFiscalEntradaDriftProvider: FiscalNotaFiscalEntradaDriftProvider()))),
		];
	}
}
