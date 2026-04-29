import 'package:get/get.dart';
import 'package:cadastros/app/controller/tipo_admissao_controller.dart';
import 'package:cadastros/app/data/provider/api/tipo_admissao_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/tipo_admissao_drift_provider.dart';
import 'package:cadastros/app/data/repository/tipo_admissao_repository.dart';

class TipoAdmissaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TipoAdmissaoController>(() => TipoAdmissaoController(
					tipoAdmissaoRepository:
							TipoAdmissaoRepository(tipoAdmissaoApiProvider: TipoAdmissaoApiProvider(), tipoAdmissaoDriftProvider: TipoAdmissaoDriftProvider()))),
		];
	}
}
