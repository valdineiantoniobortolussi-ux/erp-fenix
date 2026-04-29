import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_relogio_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_relogio_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoRelogioRepository {
  final PontoRelogioApiProvider pontoRelogioApiProvider;
  final PontoRelogioDriftProvider pontoRelogioDriftProvider;

  PontoRelogioRepository({required this.pontoRelogioApiProvider, required this.pontoRelogioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoRelogioDriftProvider.getList(filter: filter);
    } else {
      return await pontoRelogioApiProvider.getList(filter: filter);
    }
  }

  Future<PontoRelogioModel?>? save({required PontoRelogioModel pontoRelogioModel}) async {
    if (pontoRelogioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoRelogioDriftProvider.update(pontoRelogioModel);
      } else {
        return await pontoRelogioApiProvider.update(pontoRelogioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoRelogioDriftProvider.insert(pontoRelogioModel);
      } else {
        return await pontoRelogioApiProvider.insert(pontoRelogioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoRelogioDriftProvider.delete(id) ?? false;
    } else {
      return await pontoRelogioApiProvider.delete(id) ?? false;
    }
  }
}