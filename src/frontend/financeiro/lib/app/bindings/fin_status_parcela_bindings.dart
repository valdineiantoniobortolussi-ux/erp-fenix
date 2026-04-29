import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_status_parcela_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_status_parcela_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_status_parcela_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_status_parcela_repository.dart';

class FinStatusParcelaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinStatusParcelaController>(() => FinStatusParcelaController(
					finStatusParcelaRepository:
							FinStatusParcelaRepository(finStatusParcelaApiProvider: FinStatusParcelaApiProvider(), finStatusParcelaDriftProvider: FinStatusParcelaDriftProvider()))),
		];
	}
}
