import 'package:pcp/app/infra/constants.dart';
import 'package:pcp/app/data/provider/api/patrim_bem_api_provider.dart';
import 'package:pcp/app/data/provider/drift/patrim_bem_drift_provider.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PatrimBemRepository {
  final PatrimBemApiProvider patrimBemApiProvider;
  final PatrimBemDriftProvider patrimBemDriftProvider;

  PatrimBemRepository({required this.patrimBemApiProvider, required this.patrimBemDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimBemDriftProvider.getList(filter: filter);
    } else {
      return await patrimBemApiProvider.getList(filter: filter);
    }
  }

  Future<PatrimBemModel?>? save({required PatrimBemModel patrimBemModel}) async {
    if (patrimBemModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await patrimBemDriftProvider.update(patrimBemModel);
      } else {
        return await patrimBemApiProvider.update(patrimBemModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await patrimBemDriftProvider.insert(patrimBemModel);
      } else {
        return await patrimBemApiProvider.insert(patrimBemModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimBemDriftProvider.delete(id) ?? false;
    } else {
      return await patrimBemApiProvider.delete(id) ?? false;
    }
  }
}