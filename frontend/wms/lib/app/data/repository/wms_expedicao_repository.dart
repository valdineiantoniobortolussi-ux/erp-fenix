import 'package:wms/app/infra/constants.dart';
import 'package:wms/app/data/provider/api/wms_expedicao_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_expedicao_drift_provider.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsExpedicaoRepository {
  final WmsExpedicaoApiProvider wmsExpedicaoApiProvider;
  final WmsExpedicaoDriftProvider wmsExpedicaoDriftProvider;

  WmsExpedicaoRepository({required this.wmsExpedicaoApiProvider, required this.wmsExpedicaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsExpedicaoDriftProvider.getList(filter: filter);
    } else {
      return await wmsExpedicaoApiProvider.getList(filter: filter);
    }
  }

  Future<WmsExpedicaoModel?>? save({required WmsExpedicaoModel wmsExpedicaoModel}) async {
    if (wmsExpedicaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await wmsExpedicaoDriftProvider.update(wmsExpedicaoModel);
      } else {
        return await wmsExpedicaoApiProvider.update(wmsExpedicaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await wmsExpedicaoDriftProvider.insert(wmsExpedicaoModel);
      } else {
        return await wmsExpedicaoApiProvider.insert(wmsExpedicaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsExpedicaoDriftProvider.delete(id) ?? false;
    } else {
      return await wmsExpedicaoApiProvider.delete(id) ?? false;
    }
  }
}