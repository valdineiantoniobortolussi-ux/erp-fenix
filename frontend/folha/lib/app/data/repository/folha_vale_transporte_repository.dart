import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_vale_transporte_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_vale_transporte_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaValeTransporteRepository {
  final FolhaValeTransporteApiProvider folhaValeTransporteApiProvider;
  final FolhaValeTransporteDriftProvider folhaValeTransporteDriftProvider;

  FolhaValeTransporteRepository({required this.folhaValeTransporteApiProvider, required this.folhaValeTransporteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaValeTransporteDriftProvider.getList(filter: filter);
    } else {
      return await folhaValeTransporteApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaValeTransporteModel?>? save({required FolhaValeTransporteModel folhaValeTransporteModel}) async {
    if (folhaValeTransporteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaValeTransporteDriftProvider.update(folhaValeTransporteModel);
      } else {
        return await folhaValeTransporteApiProvider.update(folhaValeTransporteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaValeTransporteDriftProvider.insert(folhaValeTransporteModel);
      } else {
        return await folhaValeTransporteApiProvider.insert(folhaValeTransporteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaValeTransporteDriftProvider.delete(id) ?? false;
    } else {
      return await folhaValeTransporteApiProvider.delete(id) ?? false;
    }
  }
}