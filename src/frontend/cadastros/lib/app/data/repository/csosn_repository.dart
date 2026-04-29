import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/csosn_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/csosn_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CsosnRepository {
  final CsosnApiProvider csosnApiProvider;
  final CsosnDriftProvider csosnDriftProvider;

  CsosnRepository({required this.csosnApiProvider, required this.csosnDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await csosnDriftProvider.getList(filter: filter);
    } else {
      return await csosnApiProvider.getList(filter: filter);
    }
  }

  Future<CsosnModel?>? save({required CsosnModel csosnModel}) async {
    if (csosnModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await csosnDriftProvider.update(csosnModel);
      } else {
        return await csosnApiProvider.update(csosnModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await csosnDriftProvider.insert(csosnModel);
      } else {
        return await csosnApiProvider.insert(csosnModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await csosnDriftProvider.delete(id) ?? false;
    } else {
      return await csosnApiProvider.delete(id) ?? false;
    }
  }
}