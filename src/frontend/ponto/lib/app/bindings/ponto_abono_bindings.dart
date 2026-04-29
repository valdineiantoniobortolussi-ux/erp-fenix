import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_abono_controller.dart';
import 'package:ponto/app/data/provider/api/ponto_abono_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_abono_drift_provider.dart';
import 'package:ponto/app/data/repository/ponto_abono_repository.dart';

class PontoAbonoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PontoAbonoController>(() => PontoAbonoController(
					pontoAbonoRepository:
							PontoAbonoRepository(pontoAbonoApiProvider: PontoAbonoApiProvider(), pontoAbonoDriftProvider: PontoAbonoDriftProvider()))),
		];
	}
}
