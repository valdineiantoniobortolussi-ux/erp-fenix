import 'package:sped/app/infra/constants.dart';
import 'package:sped/app/data/provider/api/sped_contabil_api_provider.dart';
import 'package:sped/app/data/provider/drift/sped_contabil_drift_provider.dart';
import 'package:sped/app/data/model/model_imports.dart';

class SpedContabilRepository {
  final SpedContabilApiProvider spedContabilApiProvider;
  final SpedContabilDriftProvider spedContabilDriftProvider;

  SpedContabilRepository({required this.spedContabilApiProvider, required this.spedContabilDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await spedContabilDriftProvider.getList(filter: filter);
    } else {
      return await spedContabilApiProvider.getList(filter: filter);
    }
  }

  Future<SpedContabilModel?>? save({required SpedContabilModel spedContabilModel}) async {
    if (spedContabilModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await spedContabilDriftProvider.update(spedContabilModel);
      } else {
        return await spedContabilApiProvider.update(spedContabilModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await spedContabilDriftProvider.insert(spedContabilModel);
      } else {
        return await spedContabilApiProvider.insert(spedContabilModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await spedContabilDriftProvider.delete(id) ?? false;
    } else {
      return await spedContabilApiProvider.delete(id) ?? false;
    }
  }
}