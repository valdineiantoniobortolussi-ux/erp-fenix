import 'package:tributacao/app/infra/constants.dart';
import 'package:tributacao/app/data/provider/api/tribut_iss_api_provider.dart';
import 'package:tributacao/app/data/provider/drift/tribut_iss_drift_provider.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributIssRepository {
  final TributIssApiProvider tributIssApiProvider;
  final TributIssDriftProvider tributIssDriftProvider;

  TributIssRepository({required this.tributIssApiProvider, required this.tributIssDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tributIssDriftProvider.getList(filter: filter);
    } else {
      return await tributIssApiProvider.getList(filter: filter);
    }
  }

  Future<TributIssModel?>? save({required TributIssModel tributIssModel}) async {
    if (tributIssModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tributIssDriftProvider.update(tributIssModel);
      } else {
        return await tributIssApiProvider.update(tributIssModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tributIssDriftProvider.insert(tributIssModel);
      } else {
        return await tributIssApiProvider.insert(tributIssModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tributIssDriftProvider.delete(id) ?? false;
    } else {
      return await tributIssApiProvider.delete(id) ?? false;
    }
  }
}