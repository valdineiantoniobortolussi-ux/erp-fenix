import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_lancamento_pagar_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_lancamento_pagar_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinLancamentoPagarRepository {
  final FinLancamentoPagarApiProvider finLancamentoPagarApiProvider;
  final FinLancamentoPagarDriftProvider finLancamentoPagarDriftProvider;

  FinLancamentoPagarRepository({required this.finLancamentoPagarApiProvider, required this.finLancamentoPagarDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finLancamentoPagarDriftProvider.getList(filter: filter);
    } else {
      return await finLancamentoPagarApiProvider.getList(filter: filter);
    }
  }

  Future<FinLancamentoPagarModel?>? save({required FinLancamentoPagarModel finLancamentoPagarModel}) async {
    if (finLancamentoPagarModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finLancamentoPagarDriftProvider.update(finLancamentoPagarModel);
      } else {
        return await finLancamentoPagarApiProvider.update(finLancamentoPagarModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finLancamentoPagarDriftProvider.insert(finLancamentoPagarModel);
      } else {
        return await finLancamentoPagarApiProvider.insert(finLancamentoPagarModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finLancamentoPagarDriftProvider.delete(id) ?? false;
    } else {
      return await finLancamentoPagarApiProvider.delete(id) ?? false;
    }
  }
}