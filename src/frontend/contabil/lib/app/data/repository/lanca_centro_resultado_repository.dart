import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/lanca_centro_resultado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/lanca_centro_resultado_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class LancaCentroResultadoRepository {
  final LancaCentroResultadoApiProvider lancaCentroResultadoApiProvider;
  final LancaCentroResultadoDriftProvider lancaCentroResultadoDriftProvider;

  LancaCentroResultadoRepository({required this.lancaCentroResultadoApiProvider, required this.lancaCentroResultadoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await lancaCentroResultadoDriftProvider.getList(filter: filter);
    } else {
      return await lancaCentroResultadoApiProvider.getList(filter: filter);
    }
  }

  Future<LancaCentroResultadoModel?>? save({required LancaCentroResultadoModel lancaCentroResultadoModel}) async {
    if (lancaCentroResultadoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await lancaCentroResultadoDriftProvider.update(lancaCentroResultadoModel);
      } else {
        return await lancaCentroResultadoApiProvider.update(lancaCentroResultadoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await lancaCentroResultadoDriftProvider.insert(lancaCentroResultadoModel);
      } else {
        return await lancaCentroResultadoApiProvider.insert(lancaCentroResultadoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await lancaCentroResultadoDriftProvider.delete(id) ?? false;
    } else {
      return await lancaCentroResultadoApiProvider.delete(id) ?? false;
    }
  }
}