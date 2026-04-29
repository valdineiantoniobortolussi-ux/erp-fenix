import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_cheque_emitido_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_cheque_emitido_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_cheque_emitido_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_cheque_emitido_repository.dart';

class FinChequeEmitidoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinChequeEmitidoController>(() => FinChequeEmitidoController(
					finChequeEmitidoRepository:
							FinChequeEmitidoRepository(finChequeEmitidoApiProvider: FinChequeEmitidoApiProvider(), finChequeEmitidoDriftProvider: FinChequeEmitidoDriftProvider()))),
		];
	}
}
