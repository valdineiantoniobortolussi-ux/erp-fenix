import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_motorista_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_motorista_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioMotoristaRepository {
  final CteRodoviarioMotoristaApiProvider cteRodoviarioMotoristaApiProvider;
  final CteRodoviarioMotoristaDriftProvider cteRodoviarioMotoristaDriftProvider;

  CteRodoviarioMotoristaRepository({required this.cteRodoviarioMotoristaApiProvider, required this.cteRodoviarioMotoristaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioMotoristaDriftProvider.getList(filter: filter);
    } else {
      return await cteRodoviarioMotoristaApiProvider.getList(filter: filter);
    }
  }

  Future<CteRodoviarioMotoristaModel?>? save({required CteRodoviarioMotoristaModel cteRodoviarioMotoristaModel}) async {
    if (cteRodoviarioMotoristaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioMotoristaDriftProvider.update(cteRodoviarioMotoristaModel);
      } else {
        return await cteRodoviarioMotoristaApiProvider.update(cteRodoviarioMotoristaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioMotoristaDriftProvider.insert(cteRodoviarioMotoristaModel);
      } else {
        return await cteRodoviarioMotoristaApiProvider.insert(cteRodoviarioMotoristaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioMotoristaDriftProvider.delete(id) ?? false;
    } else {
      return await cteRodoviarioMotoristaApiProvider.delete(id) ?? false;
    }
  }
}