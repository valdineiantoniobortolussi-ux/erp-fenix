import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_lancamento_cabecalho_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_lancamento_cabecalho_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoCabecalhoRepository {
  final ContabilLancamentoCabecalhoApiProvider contabilLancamentoCabecalhoApiProvider;
  final ContabilLancamentoCabecalhoDriftProvider contabilLancamentoCabecalhoDriftProvider;

  ContabilLancamentoCabecalhoRepository({required this.contabilLancamentoCabecalhoApiProvider, required this.contabilLancamentoCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLancamentoCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await contabilLancamentoCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilLancamentoCabecalhoModel?>? save({required ContabilLancamentoCabecalhoModel contabilLancamentoCabecalhoModel}) async {
    if (contabilLancamentoCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilLancamentoCabecalhoDriftProvider.update(contabilLancamentoCabecalhoModel);
      } else {
        return await contabilLancamentoCabecalhoApiProvider.update(contabilLancamentoCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilLancamentoCabecalhoDriftProvider.insert(contabilLancamentoCabecalhoModel);
      } else {
        return await contabilLancamentoCabecalhoApiProvider.insert(contabilLancamentoCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLancamentoCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await contabilLancamentoCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}