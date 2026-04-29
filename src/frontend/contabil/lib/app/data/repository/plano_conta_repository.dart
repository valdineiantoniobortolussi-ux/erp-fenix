import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/plano_conta_api_provider.dart';
import 'package:contabil/app/data/provider/drift/plano_conta_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class PlanoContaRepository {
  final PlanoContaApiProvider planoContaApiProvider;
  final PlanoContaDriftProvider planoContaDriftProvider;

  PlanoContaRepository({required this.planoContaApiProvider, required this.planoContaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await planoContaDriftProvider.getList(filter: filter);
    } else {
      return await planoContaApiProvider.getList(filter: filter);
    }
  }

  Future<PlanoContaModel?>? save({required PlanoContaModel planoContaModel}) async {
    if (planoContaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await planoContaDriftProvider.update(planoContaModel);
      } else {
        return await planoContaApiProvider.update(planoContaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await planoContaDriftProvider.insert(planoContaModel);
      } else {
        return await planoContaApiProvider.insert(planoContaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await planoContaDriftProvider.delete(id) ?? false;
    } else {
      return await planoContaApiProvider.delete(id) ?? false;
    }
  }
}