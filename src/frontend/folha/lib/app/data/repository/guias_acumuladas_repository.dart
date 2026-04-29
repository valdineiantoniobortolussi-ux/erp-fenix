import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/guias_acumuladas_api_provider.dart';
import 'package:folha/app/data/provider/drift/guias_acumuladas_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class GuiasAcumuladasRepository {
  final GuiasAcumuladasApiProvider guiasAcumuladasApiProvider;
  final GuiasAcumuladasDriftProvider guiasAcumuladasDriftProvider;

  GuiasAcumuladasRepository({required this.guiasAcumuladasApiProvider, required this.guiasAcumuladasDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await guiasAcumuladasDriftProvider.getList(filter: filter);
    } else {
      return await guiasAcumuladasApiProvider.getList(filter: filter);
    }
  }

  Future<GuiasAcumuladasModel?>? save({required GuiasAcumuladasModel guiasAcumuladasModel}) async {
    if (guiasAcumuladasModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await guiasAcumuladasDriftProvider.update(guiasAcumuladasModel);
      } else {
        return await guiasAcumuladasApiProvider.update(guiasAcumuladasModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await guiasAcumuladasDriftProvider.insert(guiasAcumuladasModel);
      } else {
        return await guiasAcumuladasApiProvider.insert(guiasAcumuladasModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await guiasAcumuladasDriftProvider.delete(id) ?? false;
    } else {
      return await guiasAcumuladasApiProvider.delete(id) ?? false;
    }
  }
}