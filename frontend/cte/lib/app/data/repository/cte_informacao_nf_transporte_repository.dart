import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_informacao_nf_transporte_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_informacao_nf_transporte_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInformacaoNfTransporteRepository {
  final CteInformacaoNfTransporteApiProvider cteInformacaoNfTransporteApiProvider;
  final CteInformacaoNfTransporteDriftProvider cteInformacaoNfTransporteDriftProvider;

  CteInformacaoNfTransporteRepository({required this.cteInformacaoNfTransporteApiProvider, required this.cteInformacaoNfTransporteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteInformacaoNfTransporteDriftProvider.getList(filter: filter);
    } else {
      return await cteInformacaoNfTransporteApiProvider.getList(filter: filter);
    }
  }

  Future<CteInformacaoNfTransporteModel?>? save({required CteInformacaoNfTransporteModel cteInformacaoNfTransporteModel}) async {
    if (cteInformacaoNfTransporteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteInformacaoNfTransporteDriftProvider.update(cteInformacaoNfTransporteModel);
      } else {
        return await cteInformacaoNfTransporteApiProvider.update(cteInformacaoNfTransporteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteInformacaoNfTransporteDriftProvider.insert(cteInformacaoNfTransporteModel);
      } else {
        return await cteInformacaoNfTransporteApiProvider.insert(cteInformacaoNfTransporteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteInformacaoNfTransporteDriftProvider.delete(id) ?? false;
    } else {
      return await cteInformacaoNfTransporteApiProvider.delete(id) ?? false;
    }
  }
}