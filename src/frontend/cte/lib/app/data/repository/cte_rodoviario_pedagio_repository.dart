import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_pedagio_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_pedagio_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioPedagioRepository {
  final CteRodoviarioPedagioApiProvider cteRodoviarioPedagioApiProvider;
  final CteRodoviarioPedagioDriftProvider cteRodoviarioPedagioDriftProvider;

  CteRodoviarioPedagioRepository({required this.cteRodoviarioPedagioApiProvider, required this.cteRodoviarioPedagioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioPedagioDriftProvider.getList(filter: filter);
    } else {
      return await cteRodoviarioPedagioApiProvider.getList(filter: filter);
    }
  }

  Future<CteRodoviarioPedagioModel?>? save({required CteRodoviarioPedagioModel cteRodoviarioPedagioModel}) async {
    if (cteRodoviarioPedagioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioPedagioDriftProvider.update(cteRodoviarioPedagioModel);
      } else {
        return await cteRodoviarioPedagioApiProvider.update(cteRodoviarioPedagioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioPedagioDriftProvider.insert(cteRodoviarioPedagioModel);
      } else {
        return await cteRodoviarioPedagioApiProvider.insert(cteRodoviarioPedagioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioPedagioDriftProvider.delete(id) ?? false;
    } else {
      return await cteRodoviarioPedagioApiProvider.delete(id) ?? false;
    }
  }
}