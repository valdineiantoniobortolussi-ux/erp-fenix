import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_veiculo_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_veiculo_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioVeiculoRepository {
  final CteRodoviarioVeiculoApiProvider cteRodoviarioVeiculoApiProvider;
  final CteRodoviarioVeiculoDriftProvider cteRodoviarioVeiculoDriftProvider;

  CteRodoviarioVeiculoRepository({required this.cteRodoviarioVeiculoApiProvider, required this.cteRodoviarioVeiculoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioVeiculoDriftProvider.getList(filter: filter);
    } else {
      return await cteRodoviarioVeiculoApiProvider.getList(filter: filter);
    }
  }

  Future<CteRodoviarioVeiculoModel?>? save({required CteRodoviarioVeiculoModel cteRodoviarioVeiculoModel}) async {
    if (cteRodoviarioVeiculoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioVeiculoDriftProvider.update(cteRodoviarioVeiculoModel);
      } else {
        return await cteRodoviarioVeiculoApiProvider.update(cteRodoviarioVeiculoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioVeiculoDriftProvider.insert(cteRodoviarioVeiculoModel);
      } else {
        return await cteRodoviarioVeiculoApiProvider.insert(cteRodoviarioVeiculoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioVeiculoDriftProvider.delete(id) ?? false;
    } else {
      return await cteRodoviarioVeiculoApiProvider.delete(id) ?? false;
    }
  }
}