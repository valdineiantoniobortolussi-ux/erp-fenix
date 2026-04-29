import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_cheque_recebido_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_cheque_recebido_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_cheque_recebido_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_cheque_recebido_repository.dart';

class FinChequeRecebidoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinChequeRecebidoController>(() => FinChequeRecebidoController(
					finChequeRecebidoRepository:
							FinChequeRecebidoRepository(finChequeRecebidoApiProvider: FinChequeRecebidoApiProvider(), finChequeRecebidoDriftProvider: FinChequeRecebidoDriftProvider()))),
		];
	}
}
