import 'package:agenda/app/infra/constants.dart';
import 'package:agenda/app/data/provider/api/agenda_compromisso_api_provider.dart';
import 'package:agenda/app/data/provider/drift/agenda_compromisso_drift_provider.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class AgendaCompromissoRepository {
  final AgendaCompromissoApiProvider agendaCompromissoApiProvider;
  final AgendaCompromissoDriftProvider agendaCompromissoDriftProvider;

  AgendaCompromissoRepository({required this.agendaCompromissoApiProvider, required this.agendaCompromissoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await agendaCompromissoDriftProvider.getList(filter: filter);
    } else {
      return await agendaCompromissoApiProvider.getList(filter: filter);
    }
  }

  Future<AgendaCompromissoModel?>? save({required AgendaCompromissoModel agendaCompromissoModel}) async {
    if (agendaCompromissoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await agendaCompromissoDriftProvider.update(agendaCompromissoModel);
      } else {
        return await agendaCompromissoApiProvider.update(agendaCompromissoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await agendaCompromissoDriftProvider.insert(agendaCompromissoModel);
      } else {
        return await agendaCompromissoApiProvider.insert(agendaCompromissoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await agendaCompromissoDriftProvider.delete(id) ?? false;
    } else {
      return await agendaCompromissoApiProvider.delete(id) ?? false;
    }
  }
}