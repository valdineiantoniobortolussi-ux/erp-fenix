import 'package:wms/app/infra/constants.dart';
import 'package:wms/app/data/provider/api/wms_ordem_separacao_cab_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_ordem_separacao_cab_drift_provider.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsOrdemSeparacaoCabRepository {
  final WmsOrdemSeparacaoCabApiProvider wmsOrdemSeparacaoCabApiProvider;
  final WmsOrdemSeparacaoCabDriftProvider wmsOrdemSeparacaoCabDriftProvider;

  WmsOrdemSeparacaoCabRepository({required this.wmsOrdemSeparacaoCabApiProvider, required this.wmsOrdemSeparacaoCabDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsOrdemSeparacaoCabDriftProvider.getList(filter: filter);
    } else {
      return await wmsOrdemSeparacaoCabApiProvider.getList(filter: filter);
    }
  }

  Future<WmsOrdemSeparacaoCabModel?>? save({required WmsOrdemSeparacaoCabModel wmsOrdemSeparacaoCabModel}) async {
    if (wmsOrdemSeparacaoCabModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await wmsOrdemSeparacaoCabDriftProvider.update(wmsOrdemSeparacaoCabModel);
      } else {
        return await wmsOrdemSeparacaoCabApiProvider.update(wmsOrdemSeparacaoCabModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await wmsOrdemSeparacaoCabDriftProvider.insert(wmsOrdemSeparacaoCabModel);
      } else {
        return await wmsOrdemSeparacaoCabApiProvider.insert(wmsOrdemSeparacaoCabModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsOrdemSeparacaoCabDriftProvider.delete(id) ?? false;
    } else {
      return await wmsOrdemSeparacaoCabApiProvider.delete(id) ?? false;
    }
  }
}