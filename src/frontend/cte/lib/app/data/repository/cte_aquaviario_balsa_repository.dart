import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_aquaviario_balsa_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_aquaviario_balsa_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteAquaviarioBalsaRepository {
  final CteAquaviarioBalsaApiProvider cteAquaviarioBalsaApiProvider;
  final CteAquaviarioBalsaDriftProvider cteAquaviarioBalsaDriftProvider;

  CteAquaviarioBalsaRepository({required this.cteAquaviarioBalsaApiProvider, required this.cteAquaviarioBalsaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteAquaviarioBalsaDriftProvider.getList(filter: filter);
    } else {
      return await cteAquaviarioBalsaApiProvider.getList(filter: filter);
    }
  }

  Future<CteAquaviarioBalsaModel?>? save({required CteAquaviarioBalsaModel cteAquaviarioBalsaModel}) async {
    if (cteAquaviarioBalsaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteAquaviarioBalsaDriftProvider.update(cteAquaviarioBalsaModel);
      } else {
        return await cteAquaviarioBalsaApiProvider.update(cteAquaviarioBalsaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteAquaviarioBalsaDriftProvider.insert(cteAquaviarioBalsaModel);
      } else {
        return await cteAquaviarioBalsaApiProvider.insert(cteAquaviarioBalsaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteAquaviarioBalsaDriftProvider.delete(id) ?? false;
    } else {
      return await cteAquaviarioBalsaApiProvider.delete(id) ?? false;
    }
  }
}