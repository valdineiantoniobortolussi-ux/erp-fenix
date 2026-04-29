import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_tipo_recebimento_controller.dart';
import 'package:financeiro/app/data/provider/api/fin_tipo_recebimento_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_tipo_recebimento_drift_provider.dart';
import 'package:financeiro/app/data/repository/fin_tipo_recebimento_repository.dart';

class FinTipoRecebimentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FinTipoRecebimentoController>(() => FinTipoRecebimentoController(
					finTipoRecebimentoRepository:
							FinTipoRecebimentoRepository(finTipoRecebimentoApiProvider: FinTipoRecebimentoApiProvider(), finTipoRecebimentoDriftProvider: FinTipoRecebimentoDriftProvider()))),
		];
	}
}
