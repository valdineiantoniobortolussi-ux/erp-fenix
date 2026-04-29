import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_documento_anterior_id_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_documento_anterior_id_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteDocumentoAnteriorIdRepository {
  final CteDocumentoAnteriorIdApiProvider cteDocumentoAnteriorIdApiProvider;
  final CteDocumentoAnteriorIdDriftProvider cteDocumentoAnteriorIdDriftProvider;

  CteDocumentoAnteriorIdRepository({required this.cteDocumentoAnteriorIdApiProvider, required this.cteDocumentoAnteriorIdDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteDocumentoAnteriorIdDriftProvider.getList(filter: filter);
    } else {
      return await cteDocumentoAnteriorIdApiProvider.getList(filter: filter);
    }
  }

  Future<CteDocumentoAnteriorIdModel?>? save({required CteDocumentoAnteriorIdModel cteDocumentoAnteriorIdModel}) async {
    if (cteDocumentoAnteriorIdModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteDocumentoAnteriorIdDriftProvider.update(cteDocumentoAnteriorIdModel);
      } else {
        return await cteDocumentoAnteriorIdApiProvider.update(cteDocumentoAnteriorIdModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteDocumentoAnteriorIdDriftProvider.insert(cteDocumentoAnteriorIdModel);
      } else {
        return await cteDocumentoAnteriorIdApiProvider.insert(cteDocumentoAnteriorIdModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteDocumentoAnteriorIdDriftProvider.delete(id) ?? false;
    } else {
      return await cteDocumentoAnteriorIdApiProvider.delete(id) ?? false;
    }
  }
}