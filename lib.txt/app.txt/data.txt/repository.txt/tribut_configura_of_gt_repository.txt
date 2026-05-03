import 'package:tributacao/app/infra/constants.dart';
import 'package:tributacao/app/data/provider/api/tribut_configura_of_gt_api_provider.dart';
import 'package:tributacao/app/data/provider/drift/tribut_configura_of_gt_drift_provider.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributConfiguraOfGtRepository {
  final TributConfiguraOfGtApiProvider tributConfiguraOfGtApiProvider;
  final TributConfiguraOfGtDriftProvider tributConfiguraOfGtDriftProvider;

  TributConfiguraOfGtRepository({required this.tributConfiguraOfGtApiProvider, required this.tributConfiguraOfGtDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tributConfiguraOfGtDriftProvider.getList(filter: filter);
    } else {
      return await tributConfiguraOfGtApiProvider.getList(filter: filter);
    }
  }

  Future<TributConfiguraOfGtModel?>? save({required TributConfiguraOfGtModel tributConfiguraOfGtModel}) async {
    if (tributConfiguraOfGtModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tributConfiguraOfGtDriftProvider.update(tributConfiguraOfGtModel);
      } else {
        return await tributConfiguraOfGtApiProvider.update(tributConfiguraOfGtModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tributConfiguraOfGtDriftProvider.insert(tributConfiguraOfGtModel);
      } else {
        return await tributConfiguraOfGtApiProvider.insert(tributConfiguraOfGtModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tributConfiguraOfGtDriftProvider.delete(id) ?? false;
    } else {
      return await tributConfiguraOfGtApiProvider.delete(id) ?? false;
    }
  }
}