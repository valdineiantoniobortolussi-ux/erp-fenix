import 'package:administrativo/app/infra/constants.dart';
import 'package:administrativo/app/data/provider/api/funcao_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/funcao_drift_provider.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class FuncaoRepository {
  final FuncaoApiProvider funcaoApiProvider;
  final FuncaoDriftProvider funcaoDriftProvider;

  FuncaoRepository({required this.funcaoApiProvider, required this.funcaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await funcaoDriftProvider.getList(filter: filter);
    } else {
      return await funcaoApiProvider.getList(filter: filter);
    }
  }

  Future<FuncaoModel?>? save({required FuncaoModel funcaoModel}) async {
    if (funcaoModel.id != null) {
      if (Constants.usingLocalDatabase) {
        return await funcaoDriftProvider.update(funcaoModel);
      } else {
        return await funcaoApiProvider.update(funcaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await funcaoDriftProvider.insert(funcaoModel);
      } else {
        return await funcaoApiProvider.insert(funcaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await funcaoDriftProvider.delete(id) ?? false;
    } else {
      return await funcaoApiProvider.delete(id) ?? false;
    }
  }
}