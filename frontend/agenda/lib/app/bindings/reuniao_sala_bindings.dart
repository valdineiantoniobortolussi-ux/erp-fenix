import 'package:get/get.dart';
import 'package:agenda/app/controller/reuniao_sala_controller.dart';
import 'package:agenda/app/data/provider/api/reuniao_sala_api_provider.dart';
import 'package:agenda/app/data/provider/drift/reuniao_sala_drift_provider.dart';
import 'package:agenda/app/data/repository/reuniao_sala_repository.dart';

class ReuniaoSalaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ReuniaoSalaController>(() => ReuniaoSalaController(
					reuniaoSalaRepository:
							ReuniaoSalaRepository(reuniaoSalaApiProvider: ReuniaoSalaApiProvider(), reuniaoSalaDriftProvider: ReuniaoSalaDriftProvider()))),
		];
	}
}
