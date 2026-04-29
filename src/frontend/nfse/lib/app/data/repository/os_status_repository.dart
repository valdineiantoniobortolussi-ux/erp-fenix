import 'package:nfse/app/infra/constants.dart';
import 'package:nfse/app/data/provider/api/os_status_api_provider.dart';
import 'package:nfse/app/data/provider/drift/os_status_drift_provider.dart';
import 'package:nfse/app/data/model/model_imports.dart';

class OsStatusRepository {
  final OsStatusApiProvider osStatusApiProvider;
  final OsStatusDriftProvider osStatusDriftProvider;

  OsStatusRepository({required this.osStatusApiProvider, required this.osStatusDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await osStatusDriftProvider.getList(filter: filter);
    } else {
      return await osStatusApiProvider.getList(filter: filter);
    }
  }

  Future<OsStatusModel?>? save({required OsStatusModel osStatusModel}) async {
    if (osStatusModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await osStatusDriftProvider.update(osStatusModel);
      } else {
        return await osStatusApiProvider.update(osStatusModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await osStatusDriftProvider.insert(osStatusModel);
      } else {
        return await osStatusApiProvider.insert(osStatusModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await osStatusDriftProvider.delete(id) ?? false;
    } else {
      return await osStatusApiProvider.delete(id) ?? false;
    }
  }
}