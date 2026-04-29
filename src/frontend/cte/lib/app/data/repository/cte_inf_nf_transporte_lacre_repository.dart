import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_inf_nf_transporte_lacre_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_inf_nf_transporte_lacre_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInfNfTransporteLacreRepository {
  final CteInfNfTransporteLacreApiProvider cteInfNfTransporteLacreApiProvider;
  final CteInfNfTransporteLacreDriftProvider cteInfNfTransporteLacreDriftProvider;

  CteInfNfTransporteLacreRepository({required this.cteInfNfTransporteLacreApiProvider, required this.cteInfNfTransporteLacreDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteInfNfTransporteLacreDriftProvider.getList(filter: filter);
    } else {
      return await cteInfNfTransporteLacreApiProvider.getList(filter: filter);
    }
  }

  Future<CteInfNfTransporteLacreModel?>? save({required CteInfNfTransporteLacreModel cteInfNfTransporteLacreModel}) async {
    if (cteInfNfTransporteLacreModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteInfNfTransporteLacreDriftProvider.update(cteInfNfTransporteLacreModel);
      } else {
        return await cteInfNfTransporteLacreApiProvider.update(cteInfNfTransporteLacreModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteInfNfTransporteLacreDriftProvider.insert(cteInfNfTransporteLacreModel);
      } else {
        return await cteInfNfTransporteLacreApiProvider.insert(cteInfNfTransporteLacreModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteInfNfTransporteLacreDriftProvider.delete(id) ?? false;
    } else {
      return await cteInfNfTransporteLacreApiProvider.delete(id) ?? false;
    }
  }
}