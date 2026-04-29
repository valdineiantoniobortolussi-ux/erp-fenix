import 'package:wms/app/infra/constants.dart';
import 'package:wms/app/data/provider/api/wms_parametro_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_parametro_drift_provider.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsParametroRepository {
  final WmsParametroApiProvider wmsParametroApiProvider;
  final WmsParametroDriftProvider wmsParametroDriftProvider;

  WmsParametroRepository({required this.wmsParametroApiProvider, required this.wmsParametroDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsParametroDriftProvider.getList(filter: filter);
    } else {
      return await wmsParametroApiProvider.getList(filter: filter);
    }
  }

  Future<WmsParametroModel?>? save({required WmsParametroModel wmsParametroModel}) async {
    if (wmsParametroModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await wmsParametroDriftProvider.update(wmsParametroModel);
      } else {
        return await wmsParametroApiProvider.update(wmsParametroModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await wmsParametroDriftProvider.insert(wmsParametroModel);
      } else {
        return await wmsParametroApiProvider.insert(wmsParametroModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsParametroDriftProvider.delete(id) ?? false;
    } else {
      return await wmsParametroApiProvider.delete(id) ?? false;
    }
  }
}