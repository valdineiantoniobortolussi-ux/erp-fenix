import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_informacao_nf_carga_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_informacao_nf_carga_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInformacaoNfCargaRepository {
  final CteInformacaoNfCargaApiProvider cteInformacaoNfCargaApiProvider;
  final CteInformacaoNfCargaDriftProvider cteInformacaoNfCargaDriftProvider;

  CteInformacaoNfCargaRepository({required this.cteInformacaoNfCargaApiProvider, required this.cteInformacaoNfCargaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteInformacaoNfCargaDriftProvider.getList(filter: filter);
    } else {
      return await cteInformacaoNfCargaApiProvider.getList(filter: filter);
    }
  }

  Future<CteInformacaoNfCargaModel?>? save({required CteInformacaoNfCargaModel cteInformacaoNfCargaModel}) async {
    if (cteInformacaoNfCargaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteInformacaoNfCargaDriftProvider.update(cteInformacaoNfCargaModel);
      } else {
        return await cteInformacaoNfCargaApiProvider.update(cteInformacaoNfCargaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteInformacaoNfCargaDriftProvider.insert(cteInformacaoNfCargaModel);
      } else {
        return await cteInformacaoNfCargaApiProvider.insert(cteInformacaoNfCargaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteInformacaoNfCargaDriftProvider.delete(id) ?? false;
    } else {
      return await cteInformacaoNfCargaApiProvider.delete(id) ?? false;
    }
  }
}