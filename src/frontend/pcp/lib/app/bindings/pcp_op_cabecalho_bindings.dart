import 'package:get/get.dart';
import 'package:pcp/app/controller/pcp_op_cabecalho_controller.dart';
import 'package:pcp/app/data/provider/api/pcp_op_cabecalho_api_provider.dart';
import 'package:pcp/app/data/provider/drift/pcp_op_cabecalho_drift_provider.dart';
import 'package:pcp/app/data/repository/pcp_op_cabecalho_repository.dart';

class PcpOpCabecalhoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PcpOpCabecalhoController>(() => PcpOpCabecalhoController(
					pcpOpCabecalhoRepository:
							PcpOpCabecalhoRepository(pcpOpCabecalhoApiProvider: PcpOpCabecalhoApiProvider(), pcpOpCabecalhoDriftProvider: PcpOpCabecalhoDriftProvider()))),
		];
	}
}
