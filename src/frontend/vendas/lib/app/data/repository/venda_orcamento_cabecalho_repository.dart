import 'package:vendas/app/infra/constants.dart';
import 'package:vendas/app/data/provider/api/venda_orcamento_cabecalho_api_provider.dart';
import 'package:vendas/app/data/provider/drift/venda_orcamento_cabecalho_drift_provider.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class VendaOrcamentoCabecalhoRepository {
  final VendaOrcamentoCabecalhoApiProvider vendaOrcamentoCabecalhoApiProvider;
  final VendaOrcamentoCabecalhoDriftProvider vendaOrcamentoCabecalhoDriftProvider;

  VendaOrcamentoCabecalhoRepository({required this.vendaOrcamentoCabecalhoApiProvider, required this.vendaOrcamentoCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await vendaOrcamentoCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await vendaOrcamentoCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<VendaOrcamentoCabecalhoModel?>? save({required VendaOrcamentoCabecalhoModel vendaOrcamentoCabecalhoModel}) async {
    if (vendaOrcamentoCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await vendaOrcamentoCabecalhoDriftProvider.update(vendaOrcamentoCabecalhoModel);
      } else {
        return await vendaOrcamentoCabecalhoApiProvider.update(vendaOrcamentoCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await vendaOrcamentoCabecalhoDriftProvider.insert(vendaOrcamentoCabecalhoModel);
      } else {
        return await vendaOrcamentoCabecalhoApiProvider.insert(vendaOrcamentoCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await vendaOrcamentoCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await vendaOrcamentoCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}