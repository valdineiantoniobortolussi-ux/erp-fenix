import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_historico_salarial_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_historico_salarial_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaHistoricoSalarialRepository {
  final FolhaHistoricoSalarialApiProvider folhaHistoricoSalarialApiProvider;
  final FolhaHistoricoSalarialDriftProvider folhaHistoricoSalarialDriftProvider;

  FolhaHistoricoSalarialRepository({required this.folhaHistoricoSalarialApiProvider, required this.folhaHistoricoSalarialDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaHistoricoSalarialDriftProvider.getList(filter: filter);
    } else {
      return await folhaHistoricoSalarialApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaHistoricoSalarialModel?>? save({required FolhaHistoricoSalarialModel folhaHistoricoSalarialModel}) async {
    if (folhaHistoricoSalarialModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaHistoricoSalarialDriftProvider.update(folhaHistoricoSalarialModel);
      } else {
        return await folhaHistoricoSalarialApiProvider.update(folhaHistoricoSalarialModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaHistoricoSalarialDriftProvider.insert(folhaHistoricoSalarialModel);
      } else {
        return await folhaHistoricoSalarialApiProvider.insert(folhaHistoricoSalarialModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaHistoricoSalarialDriftProvider.delete(id) ?? false;
    } else {
      return await folhaHistoricoSalarialApiProvider.delete(id) ?? false;
    }
  }
}