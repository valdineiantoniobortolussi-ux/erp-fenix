import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_horario_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_horario_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoHorarioRepository {
  final PontoHorarioApiProvider pontoHorarioApiProvider;
  final PontoHorarioDriftProvider pontoHorarioDriftProvider;

  PontoHorarioRepository({required this.pontoHorarioApiProvider, required this.pontoHorarioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoHorarioDriftProvider.getList(filter: filter);
    } else {
      return await pontoHorarioApiProvider.getList(filter: filter);
    }
  }

  Future<PontoHorarioModel?>? save({required PontoHorarioModel pontoHorarioModel}) async {
    if (pontoHorarioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoHorarioDriftProvider.update(pontoHorarioModel);
      } else {
        return await pontoHorarioApiProvider.update(pontoHorarioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoHorarioDriftProvider.insert(pontoHorarioModel);
      } else {
        return await pontoHorarioApiProvider.insert(pontoHorarioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoHorarioDriftProvider.delete(id) ?? false;
    } else {
      return await pontoHorarioApiProvider.delete(id) ?? false;
    }
  }
}