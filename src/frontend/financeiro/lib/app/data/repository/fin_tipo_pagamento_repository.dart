import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_tipo_pagamento_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_tipo_pagamento_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinTipoPagamentoRepository {
  final FinTipoPagamentoApiProvider finTipoPagamentoApiProvider;
  final FinTipoPagamentoDriftProvider finTipoPagamentoDriftProvider;

  FinTipoPagamentoRepository({required this.finTipoPagamentoApiProvider, required this.finTipoPagamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finTipoPagamentoDriftProvider.getList(filter: filter);
    } else {
      return await finTipoPagamentoApiProvider.getList(filter: filter);
    }
  }

  Future<FinTipoPagamentoModel?>? save({required FinTipoPagamentoModel finTipoPagamentoModel}) async {
    if (finTipoPagamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finTipoPagamentoDriftProvider.update(finTipoPagamentoModel);
      } else {
        return await finTipoPagamentoApiProvider.update(finTipoPagamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finTipoPagamentoDriftProvider.insert(finTipoPagamentoModel);
      } else {
        return await finTipoPagamentoApiProvider.insert(finTipoPagamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finTipoPagamentoDriftProvider.delete(id) ?? false;
    } else {
      return await finTipoPagamentoApiProvider.delete(id) ?? false;
    }
  }
}