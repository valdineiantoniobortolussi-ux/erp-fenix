import 'package:sped/app/infra/constants.dart';
import 'package:sped/app/data/provider/api/efd_reinf_api_provider.dart';
import 'package:sped/app/data/provider/drift/efd_reinf_drift_provider.dart';
import 'package:sped/app/data/model/model_imports.dart';

class EfdReinfRepository {
  final EfdReinfApiProvider efdReinfApiProvider;
  final EfdReinfDriftProvider efdReinfDriftProvider;

  EfdReinfRepository({required this.efdReinfApiProvider, required this.efdReinfDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await efdReinfDriftProvider.getList(filter: filter);
    } else {
      return await efdReinfApiProvider.getList(filter: filter);
    }
  }

  Future<EfdReinfModel?>? save({required EfdReinfModel efdReinfModel}) async {
    if (efdReinfModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await efdReinfDriftProvider.update(efdReinfModel);
      } else {
        return await efdReinfApiProvider.update(efdReinfModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await efdReinfDriftProvider.insert(efdReinfModel);
      } else {
        return await efdReinfApiProvider.insert(efdReinfModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await efdReinfDriftProvider.delete(id) ?? false;
    } else {
      return await efdReinfApiProvider.delete(id) ?? false;
    }
  }
}