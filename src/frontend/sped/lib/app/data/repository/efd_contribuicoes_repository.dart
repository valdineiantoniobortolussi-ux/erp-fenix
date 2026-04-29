import 'package:sped/app/infra/constants.dart';
import 'package:sped/app/data/provider/api/efd_contribuicoes_api_provider.dart';
import 'package:sped/app/data/provider/drift/efd_contribuicoes_drift_provider.dart';
import 'package:sped/app/data/model/model_imports.dart';

class EfdContribuicoesRepository {
  final EfdContribuicoesApiProvider efdContribuicoesApiProvider;
  final EfdContribuicoesDriftProvider efdContribuicoesDriftProvider;

  EfdContribuicoesRepository({required this.efdContribuicoesApiProvider, required this.efdContribuicoesDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await efdContribuicoesDriftProvider.getList(filter: filter);
    } else {
      return await efdContribuicoesApiProvider.getList(filter: filter);
    }
  }

  Future<EfdContribuicoesModel?>? save({required EfdContribuicoesModel efdContribuicoesModel}) async {
    if (efdContribuicoesModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await efdContribuicoesDriftProvider.update(efdContribuicoesModel);
      } else {
        return await efdContribuicoesApiProvider.update(efdContribuicoesModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await efdContribuicoesDriftProvider.insert(efdContribuicoesModel);
      } else {
        return await efdContribuicoesApiProvider.insert(efdContribuicoesModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await efdContribuicoesDriftProvider.delete(id) ?? false;
    } else {
      return await efdContribuicoesApiProvider.delete(id) ?? false;
    }
  }
}