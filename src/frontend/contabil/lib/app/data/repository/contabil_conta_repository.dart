import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_conta_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_conta_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilContaRepository {
  final ContabilContaApiProvider contabilContaApiProvider;
  final ContabilContaDriftProvider contabilContaDriftProvider;

  ContabilContaRepository({required this.contabilContaApiProvider, required this.contabilContaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilContaDriftProvider.getList(filter: filter);
    } else {
      return await contabilContaApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilContaModel?>? save({required ContabilContaModel contabilContaModel}) async {
    if (contabilContaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilContaDriftProvider.update(contabilContaModel);
      } else {
        return await contabilContaApiProvider.update(contabilContaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilContaDriftProvider.insert(contabilContaModel);
      } else {
        return await contabilContaApiProvider.insert(contabilContaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilContaDriftProvider.delete(id) ?? false;
    } else {
      return await contabilContaApiProvider.delete(id) ?? false;
    }
  }
}