import 'package:get/get.dart';
import 'package:pcp/app/controller/pcp_servico_controller.dart';
import 'package:pcp/app/data/provider/api/pcp_servico_api_provider.dart';
import 'package:pcp/app/data/provider/drift/pcp_servico_drift_provider.dart';
import 'package:pcp/app/data/repository/pcp_servico_repository.dart';

class PcpServicoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PcpServicoController>(() => PcpServicoController(
					pcpServicoRepository:
							PcpServicoRepository(pcpServicoApiProvider: PcpServicoApiProvider(), pcpServicoDriftProvider: PcpServicoDriftProvider()))),
		];
	}
}
