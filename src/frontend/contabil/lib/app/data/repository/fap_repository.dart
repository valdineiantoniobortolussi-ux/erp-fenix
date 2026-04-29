import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/fap_api_provider.dart';
import 'package:contabil/app/data/provider/drift/fap_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class FapRepository {
  final FapApiProvider fapApiProvider;
  final FapDriftProvider fapDriftProvider;

  FapRepository({required this.fapApiProvider, required this.fapDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fapDriftProvider.getList(filter: filter);
    } else {
      return await fapApiProvider.getList(filter: filter);
    }
  }

  Future<FapModel?>? save({required FapModel fapModel}) async {
    if (fapModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fapDriftProvider.update(fapModel);
      } else {
        return await fapApiProvider.update(fapModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fapDriftProvider.insert(fapModel);
      } else {
        return await fapApiProvider.insert(fapModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fapDriftProvider.delete(id) ?? false;
    } else {
      return await fapApiProvider.delete(id) ?? false;
    }
  }
}