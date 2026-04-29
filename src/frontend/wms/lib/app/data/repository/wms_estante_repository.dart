import 'package:wms/app/infra/constants.dart';
import 'package:wms/app/data/provider/api/wms_estante_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_estante_drift_provider.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsEstanteRepository {
  final WmsEstanteApiProvider wmsEstanteApiProvider;
  final WmsEstanteDriftProvider wmsEstanteDriftProvider;

  WmsEstanteRepository({required this.wmsEstanteApiProvider, required this.wmsEstanteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsEstanteDriftProvider.getList(filter: filter);
    } else {
      return await wmsEstanteApiProvider.getList(filter: filter);
    }
  }

  Future<WmsEstanteModel?>? save({required WmsEstanteModel wmsEstanteModel}) async {
    if (wmsEstanteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await wmsEstanteDriftProvider.update(wmsEstanteModel);
      } else {
        return await wmsEstanteApiProvider.update(wmsEstanteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await wmsEstanteDriftProvider.insert(wmsEstanteModel);
      } else {
        return await wmsEstanteApiProvider.insert(wmsEstanteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsEstanteDriftProvider.delete(id) ?? false;
    } else {
      return await wmsEstanteApiProvider.delete(id) ?? false;
    }
  }
}