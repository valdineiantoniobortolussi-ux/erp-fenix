import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_inss_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_inss_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaInssRepository {
  final FolhaInssApiProvider folhaInssApiProvider;
  final FolhaInssDriftProvider folhaInssDriftProvider;

  FolhaInssRepository({required this.folhaInssApiProvider, required this.folhaInssDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaInssDriftProvider.getList(filter: filter);
    } else {
      return await folhaInssApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaInssModel?>? save({required FolhaInssModel folhaInssModel}) async {
    if (folhaInssModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaInssDriftProvider.update(folhaInssModel);
      } else {
        return await folhaInssApiProvider.update(folhaInssModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaInssDriftProvider.insert(folhaInssModel);
      } else {
        return await folhaInssApiProvider.insert(folhaInssModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaInssDriftProvider.delete(id) ?? false;
    } else {
      return await folhaInssApiProvider.delete(id) ?? false;
    }
  }
}