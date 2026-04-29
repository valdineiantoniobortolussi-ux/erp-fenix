import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_lancamento_padrao_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_lancamento_padrao_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoPadraoRepository {
  final ContabilLancamentoPadraoApiProvider contabilLancamentoPadraoApiProvider;
  final ContabilLancamentoPadraoDriftProvider contabilLancamentoPadraoDriftProvider;

  ContabilLancamentoPadraoRepository({required this.contabilLancamentoPadraoApiProvider, required this.contabilLancamentoPadraoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLancamentoPadraoDriftProvider.getList(filter: filter);
    } else {
      return await contabilLancamentoPadraoApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilLancamentoPadraoModel?>? save({required ContabilLancamentoPadraoModel contabilLancamentoPadraoModel}) async {
    if (contabilLancamentoPadraoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilLancamentoPadraoDriftProvider.update(contabilLancamentoPadraoModel);
      } else {
        return await contabilLancamentoPadraoApiProvider.update(contabilLancamentoPadraoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilLancamentoPadraoDriftProvider.insert(contabilLancamentoPadraoModel);
      } else {
        return await contabilLancamentoPadraoApiProvider.insert(contabilLancamentoPadraoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLancamentoPadraoDriftProvider.delete(id) ?? false;
    } else {
      return await contabilLancamentoPadraoApiProvider.delete(id) ?? false;
    }
  }
}