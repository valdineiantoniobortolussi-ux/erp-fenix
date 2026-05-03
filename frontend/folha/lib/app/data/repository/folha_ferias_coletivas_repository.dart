import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_ferias_coletivas_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_ferias_coletivas_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaFeriasColetivasRepository {
  final FolhaFeriasColetivasApiProvider folhaFeriasColetivasApiProvider;
  final FolhaFeriasColetivasDriftProvider folhaFeriasColetivasDriftProvider;

  FolhaFeriasColetivasRepository({required this.folhaFeriasColetivasApiProvider, required this.folhaFeriasColetivasDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaFeriasColetivasDriftProvider.getList(filter: filter);
    } else {
      return await folhaFeriasColetivasApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaFeriasColetivasModel?>? save({required FolhaFeriasColetivasModel folhaFeriasColetivasModel}) async {
    if (folhaFeriasColetivasModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaFeriasColetivasDriftProvider.update(folhaFeriasColetivasModel);
      } else {
        return await folhaFeriasColetivasApiProvider.update(folhaFeriasColetivasModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaFeriasColetivasDriftProvider.insert(folhaFeriasColetivasModel);
      } else {
        return await folhaFeriasColetivasApiProvider.insert(folhaFeriasColetivasModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaFeriasColetivasDriftProvider.delete(id) ?? false;
    } else {
      return await folhaFeriasColetivasApiProvider.delete(id) ?? false;
    }
  }
}