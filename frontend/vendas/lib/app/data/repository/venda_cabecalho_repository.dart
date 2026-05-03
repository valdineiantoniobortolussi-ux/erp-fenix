import 'package:vendas/app/infra/constants.dart';
import 'package:vendas/app/data/provider/api/venda_cabecalho_api_provider.dart';
import 'package:vendas/app/data/provider/drift/venda_cabecalho_drift_provider.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class VendaCabecalhoRepository {
  final VendaCabecalhoApiProvider vendaCabecalhoApiProvider;
  final VendaCabecalhoDriftProvider vendaCabecalhoDriftProvider;

  VendaCabecalhoRepository({required this.vendaCabecalhoApiProvider, required this.vendaCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await vendaCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await vendaCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<VendaCabecalhoModel?>? save({required VendaCabecalhoModel vendaCabecalhoModel}) async {
    if (vendaCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await vendaCabecalhoDriftProvider.update(vendaCabecalhoModel);
      } else {
        return await vendaCabecalhoApiProvider.update(vendaCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await vendaCabecalhoDriftProvider.insert(vendaCabecalhoModel);
      } else {
        return await vendaCabecalhoApiProvider.insert(vendaCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await vendaCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await vendaCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}