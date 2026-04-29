import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_lacre_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_lacre_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioLacreRepository {
  final CteRodoviarioLacreApiProvider cteRodoviarioLacreApiProvider;
  final CteRodoviarioLacreDriftProvider cteRodoviarioLacreDriftProvider;

  CteRodoviarioLacreRepository({required this.cteRodoviarioLacreApiProvider, required this.cteRodoviarioLacreDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioLacreDriftProvider.getList(filter: filter);
    } else {
      return await cteRodoviarioLacreApiProvider.getList(filter: filter);
    }
  }

  Future<CteRodoviarioLacreModel?>? save({required CteRodoviarioLacreModel cteRodoviarioLacreModel}) async {
    if (cteRodoviarioLacreModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioLacreDriftProvider.update(cteRodoviarioLacreModel);
      } else {
        return await cteRodoviarioLacreApiProvider.update(cteRodoviarioLacreModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioLacreDriftProvider.insert(cteRodoviarioLacreModel);
      } else {
        return await cteRodoviarioLacreApiProvider.insert(cteRodoviarioLacreModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioLacreDriftProvider.delete(id) ?? false;
    } else {
      return await cteRodoviarioLacreApiProvider.delete(id) ?? false;
    }
  }
}