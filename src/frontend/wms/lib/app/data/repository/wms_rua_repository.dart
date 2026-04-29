import 'package:wms/app/infra/constants.dart';
import 'package:wms/app/data/provider/api/wms_rua_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_rua_drift_provider.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsRuaRepository {
  final WmsRuaApiProvider wmsRuaApiProvider;
  final WmsRuaDriftProvider wmsRuaDriftProvider;

  WmsRuaRepository({required this.wmsRuaApiProvider, required this.wmsRuaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsRuaDriftProvider.getList(filter: filter);
    } else {
      return await wmsRuaApiProvider.getList(filter: filter);
    }
  }

  Future<WmsRuaModel?>? save({required WmsRuaModel wmsRuaModel}) async {
    if (wmsRuaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await wmsRuaDriftProvider.update(wmsRuaModel);
      } else {
        return await wmsRuaApiProvider.update(wmsRuaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await wmsRuaDriftProvider.insert(wmsRuaModel);
      } else {
        return await wmsRuaApiProvider.insert(wmsRuaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsRuaDriftProvider.delete(id) ?? false;
    } else {
      return await wmsRuaApiProvider.delete(id) ?? false;
    }
  }
}