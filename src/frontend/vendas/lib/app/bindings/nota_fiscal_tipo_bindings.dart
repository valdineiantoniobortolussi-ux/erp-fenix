import 'package:get/get.dart';
import 'package:vendas/app/controller/nota_fiscal_tipo_controller.dart';
import 'package:vendas/app/data/provider/api/nota_fiscal_tipo_api_provider.dart';
import 'package:vendas/app/data/provider/drift/nota_fiscal_tipo_drift_provider.dart';
import 'package:vendas/app/data/repository/nota_fiscal_tipo_repository.dart';

class NotaFiscalTipoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<NotaFiscalTipoController>(() => NotaFiscalTipoController(
					notaFiscalTipoRepository:
							NotaFiscalTipoRepository(notaFiscalTipoApiProvider: NotaFiscalTipoApiProvider(), notaFiscalTipoDriftProvider: NotaFiscalTipoDriftProvider()))),
		];
	}
}
