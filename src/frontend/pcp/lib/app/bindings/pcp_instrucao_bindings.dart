import 'package:get/get.dart';
import 'package:pcp/app/controller/pcp_instrucao_controller.dart';
import 'package:pcp/app/data/provider/api/pcp_instrucao_api_provider.dart';
import 'package:pcp/app/data/provider/drift/pcp_instrucao_drift_provider.dart';
import 'package:pcp/app/data/repository/pcp_instrucao_repository.dart';

class PcpInstrucaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PcpInstrucaoController>(() => PcpInstrucaoController(
					pcpInstrucaoRepository:
							PcpInstrucaoRepository(pcpInstrucaoApiProvider: PcpInstrucaoApiProvider(), pcpInstrucaoDriftProvider: PcpInstrucaoDriftProvider()))),
		];
	}
}
