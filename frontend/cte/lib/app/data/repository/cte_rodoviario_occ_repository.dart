import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_rodoviario_occ_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_rodoviario_occ_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioOccRepository {
  final CteRodoviarioOccApiProvider cteRodoviarioOccApiProvider;
  final CteRodoviarioOccDriftProvider cteRodoviarioOccDriftProvider;

  CteRodoviarioOccRepository({required this.cteRodoviarioOccApiProvider, required this.cteRodoviarioOccDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioOccDriftProvider.getList(filter: filter);
    } else {
      return await cteRodoviarioOccApiProvider.getList(filter: filter);
    }
  }

  Future<CteRodoviarioOccModel?>? save({required CteRodoviarioOccModel cteRodoviarioOccModel}) async {
    if (cteRodoviarioOccModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioOccDriftProvider.update(cteRodoviarioOccModel);
      } else {
        return await cteRodoviarioOccApiProvider.update(cteRodoviarioOccModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteRodoviarioOccDriftProvider.insert(cteRodoviarioOccModel);
      } else {
        return await cteRodoviarioOccApiProvider.insert(cteRodoviarioOccModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteRodoviarioOccDriftProvider.delete(id) ?? false;
    } else {
      return await cteRodoviarioOccApiProvider.delete(id) ?? false;
    }
  }
}