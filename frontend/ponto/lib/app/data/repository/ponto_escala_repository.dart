import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_escala_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_escala_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoEscalaRepository {
  final PontoEscalaApiProvider pontoEscalaApiProvider;
  final PontoEscalaDriftProvider pontoEscalaDriftProvider;

  PontoEscalaRepository({required this.pontoEscalaApiProvider, required this.pontoEscalaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoEscalaDriftProvider.getList(filter: filter);
    } else {
      return await pontoEscalaApiProvider.getList(filter: filter);
    }
  }

  Future<PontoEscalaModel?>? save({required PontoEscalaModel pontoEscalaModel}) async {
    if (pontoEscalaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoEscalaDriftProvider.update(pontoEscalaModel);
      } else {
        return await pontoEscalaApiProvider.update(pontoEscalaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoEscalaDriftProvider.insert(pontoEscalaModel);
      } else {
        return await pontoEscalaApiProvider.insert(pontoEscalaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoEscalaDriftProvider.delete(id) ?? false;
    } else {
      return await pontoEscalaApiProvider.delete(id) ?? false;
    }
  }
}