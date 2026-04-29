import 'package:get/get.dart';
import 'package:frotas/app/controller/frota_combustivel_tipo_controller.dart';
import 'package:frotas/app/data/provider/api/frota_combustivel_tipo_api_provider.dart';
import 'package:frotas/app/data/provider/drift/frota_combustivel_tipo_drift_provider.dart';
import 'package:frotas/app/data/repository/frota_combustivel_tipo_repository.dart';

class FrotaCombustivelTipoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<FrotaCombustivelTipoController>(() => FrotaCombustivelTipoController(
					frotaCombustivelTipoRepository:
							FrotaCombustivelTipoRepository(frotaCombustivelTipoApiProvider: FrotaCombustivelTipoApiProvider(), frotaCombustivelTipoDriftProvider: FrotaCombustivelTipoDriftProvider()))),
		];
	}
}
