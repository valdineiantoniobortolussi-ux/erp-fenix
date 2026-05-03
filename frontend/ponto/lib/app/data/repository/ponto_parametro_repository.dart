import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_parametro_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_parametro_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoParametroRepository {
  final PontoParametroApiProvider pontoParametroApiProvider;
  final PontoParametroDriftProvider pontoParametroDriftProvider;

  PontoParametroRepository({required this.pontoParametroApiProvider, required this.pontoParametroDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoParametroDriftProvider.getList(filter: filter);
    } else {
      return await pontoParametroApiProvider.getList(filter: filter);
    }
  }

  Future<PontoParametroModel?>? save({required PontoParametroModel pontoParametroModel}) async {
    if (pontoParametroModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoParametroDriftProvider.update(pontoParametroModel);
      } else {
        return await pontoParametroApiProvider.update(pontoParametroModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoParametroDriftProvider.insert(pontoParametroModel);
      } else {
        return await pontoParametroApiProvider.insert(pontoParametroModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoParametroDriftProvider.delete(id) ?? false;
    } else {
      return await pontoParametroApiProvider.delete(id) ?? false;
    }
  }
}