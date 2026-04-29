import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/plano_conta_ref_sped_api_provider.dart';
import 'package:contabil/app/data/provider/drift/plano_conta_ref_sped_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class PlanoContaRefSpedRepository {
  final PlanoContaRefSpedApiProvider planoContaRefSpedApiProvider;
  final PlanoContaRefSpedDriftProvider planoContaRefSpedDriftProvider;

  PlanoContaRefSpedRepository({required this.planoContaRefSpedApiProvider, required this.planoContaRefSpedDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await planoContaRefSpedDriftProvider.getList(filter: filter);
    } else {
      return await planoContaRefSpedApiProvider.getList(filter: filter);
    }
  }

  Future<PlanoContaRefSpedModel?>? save({required PlanoContaRefSpedModel planoContaRefSpedModel}) async {
    if (planoContaRefSpedModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await planoContaRefSpedDriftProvider.update(planoContaRefSpedModel);
      } else {
        return await planoContaRefSpedApiProvider.update(planoContaRefSpedModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await planoContaRefSpedDriftProvider.insert(planoContaRefSpedModel);
      } else {
        return await planoContaRefSpedApiProvider.insert(planoContaRefSpedModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await planoContaRefSpedDriftProvider.delete(id) ?? false;
    } else {
      return await planoContaRefSpedApiProvider.delete(id) ?? false;
    }
  }
}