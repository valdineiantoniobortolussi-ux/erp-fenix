import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_inf_nf_carga_lacre_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_inf_nf_carga_lacre_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInfNfCargaLacreRepository {
  final CteInfNfCargaLacreApiProvider cteInfNfCargaLacreApiProvider;
  final CteInfNfCargaLacreDriftProvider cteInfNfCargaLacreDriftProvider;

  CteInfNfCargaLacreRepository({required this.cteInfNfCargaLacreApiProvider, required this.cteInfNfCargaLacreDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteInfNfCargaLacreDriftProvider.getList(filter: filter);
    } else {
      return await cteInfNfCargaLacreApiProvider.getList(filter: filter);
    }
  }

  Future<CteInfNfCargaLacreModel?>? save({required CteInfNfCargaLacreModel cteInfNfCargaLacreModel}) async {
    if (cteInfNfCargaLacreModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteInfNfCargaLacreDriftProvider.update(cteInfNfCargaLacreModel);
      } else {
        return await cteInfNfCargaLacreApiProvider.update(cteInfNfCargaLacreModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteInfNfCargaLacreDriftProvider.insert(cteInfNfCargaLacreModel);
      } else {
        return await cteInfNfCargaLacreApiProvider.insert(cteInfNfCargaLacreModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteInfNfCargaLacreDriftProvider.delete(id) ?? false;
    } else {
      return await cteInfNfCargaLacreApiProvider.delete(id) ?? false;
    }
  }
}