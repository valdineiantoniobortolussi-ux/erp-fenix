import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_lancamento_receber_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_lancamento_receber_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinLancamentoReceberRepository {
  final FinLancamentoReceberApiProvider finLancamentoReceberApiProvider;
  final FinLancamentoReceberDriftProvider finLancamentoReceberDriftProvider;

  FinLancamentoReceberRepository({required this.finLancamentoReceberApiProvider, required this.finLancamentoReceberDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finLancamentoReceberDriftProvider.getList(filter: filter);
    } else {
      return await finLancamentoReceberApiProvider.getList(filter: filter);
    }
  }

  Future<FinLancamentoReceberModel?>? save({required FinLancamentoReceberModel finLancamentoReceberModel}) async {
    if (finLancamentoReceberModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finLancamentoReceberDriftProvider.update(finLancamentoReceberModel);
      } else {
        return await finLancamentoReceberApiProvider.update(finLancamentoReceberModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finLancamentoReceberDriftProvider.insert(finLancamentoReceberModel);
      } else {
        return await finLancamentoReceberApiProvider.insert(finLancamentoReceberModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finLancamentoReceberDriftProvider.delete(id) ?? false;
    } else {
      return await finLancamentoReceberApiProvider.delete(id) ?? false;
    }
  }
}