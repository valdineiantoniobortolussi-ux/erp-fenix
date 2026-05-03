import 'package:get/get.dart';
import 'package:agenda/app/controller/agenda_categoria_compromisso_controller.dart';
import 'package:agenda/app/data/provider/api/agenda_categoria_compromisso_api_provider.dart';
import 'package:agenda/app/data/provider/drift/agenda_categoria_compromisso_drift_provider.dart';
import 'package:agenda/app/data/repository/agenda_categoria_compromisso_repository.dart';

class AgendaCategoriaCompromissoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<AgendaCategoriaCompromissoController>(() => AgendaCategoriaCompromissoController(
					agendaCategoriaCompromissoRepository:
							AgendaCategoriaCompromissoRepository(agendaCategoriaCompromissoApiProvider: AgendaCategoriaCompromissoApiProvider(), agendaCategoriaCompromissoDriftProvider: AgendaCategoriaCompromissoDriftProvider()))),
		];
	}
}
