import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_natureza_financeira_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_natureza_financeira_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_natureza_financeira_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_natureza_financeira_repository.dart';

class FinNaturezaFinanceiraBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinNaturezaFinanceiraController>(() => FinNaturezaFinanceiraController(
					finNaturezaFinanceiraRepository:
							FinNaturezaFinanceiraRepository(finNaturezaFinanceiraApiProvider: FinNaturezaFinanceiraApiProvider(), finNaturezaFinanceiraDriftProvider: FinNaturezaFinanceiraDriftProvider()))),
		];
	}
}
