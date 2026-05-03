import 'package:get/get.dart';
import 'package:agenda/app/controller/agenda_compromisso_controller.dart';
import 'package:agenda/app/data/provider/api/agenda_compromisso_api_provider.dart';
import 'package:agenda/app/data/provider/drift/agenda_compromisso_drift_provider.dart';
import 'package:agenda/app/data/repository/agenda_compromisso_repository.dart';

class AgendaCompromissoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<AgendaCompromissoController>(() => AgendaCompromissoController(
					agendaCompromissoRepository:
							AgendaCompromissoRepository(agendaCompromissoApiProvider: AgendaCompromissoApiProvider(), agendaCompromissoDriftProvider: AgendaCompromissoDriftProvider()))),
		];
	}
}
