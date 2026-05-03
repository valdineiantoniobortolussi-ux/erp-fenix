import 'package:wms/app/infra/constants.dart';
import 'package:wms/app/data/provider/api/wms_recebimento_cabecalho_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_recebimento_cabecalho_drift_provider.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsRecebimentoCabecalhoRepository {
  final WmsRecebimentoCabecalhoApiProvider wmsRecebimentoCabecalhoApiProvider;
  final WmsRecebimentoCabecalhoDriftProvider wmsRecebimentoCabecalhoDriftProvider;

  WmsRecebimentoCabecalhoRepository({required this.wmsRecebimentoCabecalhoApiProvider, required this.wmsRecebimentoCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsRecebimentoCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await wmsRecebimentoCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<WmsRecebimentoCabecalhoModel?>? save({required WmsRecebimentoCabecalhoModel wmsRecebimentoCabecalhoModel}) async {
    if (wmsRecebimentoCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await wmsRecebimentoCabecalhoDriftProvider.update(wmsRecebimentoCabecalhoModel);
      } else {
        return await wmsRecebimentoCabecalhoApiProvider.update(wmsRecebimentoCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await wmsRecebimentoCabecalhoDriftProvider.insert(wmsRecebimentoCabecalhoModel);
      } else {
        return await wmsRecebimentoCabecalhoApiProvider.insert(wmsRecebimentoCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsRecebimentoCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await wmsRecebimentoCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}