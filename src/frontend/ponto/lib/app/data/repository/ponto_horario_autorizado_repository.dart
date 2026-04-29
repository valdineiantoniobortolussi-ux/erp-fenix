import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_horario_autorizado_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_horario_autorizado_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoHorarioAutorizadoRepository {
  final PontoHorarioAutorizadoApiProvider pontoHorarioAutorizadoApiProvider;
  final PontoHorarioAutorizadoDriftProvider pontoHorarioAutorizadoDriftProvider;

  PontoHorarioAutorizadoRepository({required this.pontoHorarioAutorizadoApiProvider, required this.pontoHorarioAutorizadoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoHorarioAutorizadoDriftProvider.getList(filter: filter);
    } else {
      return await pontoHorarioAutorizadoApiProvider.getList(filter: filter);
    }
  }

  Future<PontoHorarioAutorizadoModel?>? save({required PontoHorarioAutorizadoModel pontoHorarioAutorizadoModel}) async {
    if (pontoHorarioAutorizadoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoHorarioAutorizadoDriftProvider.update(pontoHorarioAutorizadoModel);
      } else {
        return await pontoHorarioAutorizadoApiProvider.update(pontoHorarioAutorizadoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoHorarioAutorizadoDriftProvider.insert(pontoHorarioAutorizadoModel);
      } else {
        return await pontoHorarioAutorizadoApiProvider.insert(pontoHorarioAutorizadoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoHorarioAutorizadoDriftProvider.delete(id) ?? false;
    } else {
      return await pontoHorarioAutorizadoApiProvider.delete(id) ?? false;
    }
  }
}