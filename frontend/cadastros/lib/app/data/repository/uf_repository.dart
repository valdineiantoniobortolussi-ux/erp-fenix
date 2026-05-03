import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/uf_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/uf_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class UfRepository {
  final UfApiProvider ufApiProvider;
  final UfDriftProvider ufDriftProvider;

  UfRepository({required this.ufApiProvider, required this.ufDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await ufDriftProvider.getList(filter: filter);
    } else {
      return await ufApiProvider.getList(filter: filter);
    }
  }

  Future<UfModel?>? save({required UfModel ufModel}) async {
    if (ufModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await ufDriftProvider.update(ufModel);
      } else {
        return await ufApiProvider.update(ufModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await ufDriftProvider.insert(ufModel);
      } else {
        return await ufApiProvider.insert(ufModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await ufDriftProvider.delete(id) ?? false;
    } else {
      return await ufApiProvider.delete(id) ?? false;
    }
  }
}