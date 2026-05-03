import 'package:vendas/app/infra/constants.dart';
import 'package:vendas/app/data/provider/api/venda_condicoes_pagamento_api_provider.dart';
import 'package:vendas/app/data/provider/drift/venda_condicoes_pagamento_drift_provider.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class VendaCondicoesPagamentoRepository {
  final VendaCondicoesPagamentoApiProvider vendaCondicoesPagamentoApiProvider;
  final VendaCondicoesPagamentoDriftProvider vendaCondicoesPagamentoDriftProvider;

  VendaCondicoesPagamentoRepository({required this.vendaCondicoesPagamentoApiProvider, required this.vendaCondicoesPagamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await vendaCondicoesPagamentoDriftProvider.getList(filter: filter);
    } else {
      return await vendaCondicoesPagamentoApiProvider.getList(filter: filter);
    }
  }

  Future<VendaCondicoesPagamentoModel?>? save({required VendaCondicoesPagamentoModel vendaCondicoesPagamentoModel}) async {
    if (vendaCondicoesPagamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await vendaCondicoesPagamentoDriftProvider.update(vendaCondicoesPagamentoModel);
      } else {
        return await vendaCondicoesPagamentoApiProvider.update(vendaCondicoesPagamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await vendaCondicoesPagamentoDriftProvider.insert(vendaCondicoesPagamentoModel);
      } else {
        return await vendaCondicoesPagamentoApiProvider.insert(vendaCondicoesPagamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await vendaCondicoesPagamentoDriftProvider.delete(id) ?? false;
    } else {
      return await vendaCondicoesPagamentoApiProvider.delete(id) ?? false;
    }
  }
}