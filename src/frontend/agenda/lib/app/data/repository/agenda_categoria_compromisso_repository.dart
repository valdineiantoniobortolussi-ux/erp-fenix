import 'package:agenda/app/infra/constants.dart';
import 'package:agenda/app/data/provider/api/agenda_categoria_compromisso_api_provider.dart';
import 'package:agenda/app/data/provider/drift/agenda_categoria_compromisso_drift_provider.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class AgendaCategoriaCompromissoRepository {
  final AgendaCategoriaCompromissoApiProvider agendaCategoriaCompromissoApiProvider;
  final AgendaCategoriaCompromissoDriftProvider agendaCategoriaCompromissoDriftProvider;

  AgendaCategoriaCompromissoRepository({required this.agendaCategoriaCompromissoApiProvider, required this.agendaCategoriaCompromissoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await agendaCategoriaCompromissoDriftProvider.getList(filter: filter);
    } else {
      return await agendaCategoriaCompromissoApiProvider.getList(filter: filter);
    }
  }

  Future<AgendaCategoriaCompromissoModel?>? save({required AgendaCategoriaCompromissoModel agendaCategoriaCompromissoModel}) async {
    if (agendaCategoriaCompromissoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await agendaCategoriaCompromissoDriftProvider.update(agendaCategoriaCompromissoModel);
      } else {
        return await agendaCategoriaCompromissoApiProvider.update(agendaCategoriaCompromissoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await agendaCategoriaCompromissoDriftProvider.insert(agendaCategoriaCompromissoModel);
      } else {
        return await agendaCategoriaCompromissoApiProvider.insert(agendaCategoriaCompromissoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await agendaCategoriaCompromissoDriftProvider.delete(id) ?? false;
    } else {
      return await agendaCategoriaCompromissoApiProvider.delete(id) ?? false;
    }
  }
}