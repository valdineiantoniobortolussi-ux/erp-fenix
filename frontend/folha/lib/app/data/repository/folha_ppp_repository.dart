import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_ppp_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_ppp_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaPppRepository {
  final FolhaPppApiProvider folhaPppApiProvider;
  final FolhaPppDriftProvider folhaPppDriftProvider;

  FolhaPppRepository({required this.folhaPppApiProvider, required this.folhaPppDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaPppDriftProvider.getList(filter: filter);
    } else {
      return await folhaPppApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaPppModel?>? save({required FolhaPppModel folhaPppModel}) async {
    if (folhaPppModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaPppDriftProvider.update(folhaPppModel);
      } else {
        return await folhaPppApiProvider.update(folhaPppModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaPppDriftProvider.insert(folhaPppModel);
      } else {
        return await folhaPppApiProvider.insert(folhaPppModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaPppDriftProvider.delete(id) ?? false;
    } else {
      return await folhaPppApiProvider.delete(id) ?? false;
    }
  }
}