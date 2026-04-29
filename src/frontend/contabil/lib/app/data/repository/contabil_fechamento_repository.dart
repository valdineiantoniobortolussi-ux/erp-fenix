import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_fechamento_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_fechamento_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilFechamentoRepository {
  final ContabilFechamentoApiProvider contabilFechamentoApiProvider;
  final ContabilFechamentoDriftProvider contabilFechamentoDriftProvider;

  ContabilFechamentoRepository({required this.contabilFechamentoApiProvider, required this.contabilFechamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilFechamentoDriftProvider.getList(filter: filter);
    } else {
      return await contabilFechamentoApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilFechamentoModel?>? save({required ContabilFechamentoModel contabilFechamentoModel}) async {
    if (contabilFechamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilFechamentoDriftProvider.update(contabilFechamentoModel);
      } else {
        return await contabilFechamentoApiProvider.update(contabilFechamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilFechamentoDriftProvider.insert(contabilFechamentoModel);
      } else {
        return await contabilFechamentoApiProvider.insert(contabilFechamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilFechamentoDriftProvider.delete(id) ?? false;
    } else {
      return await contabilFechamentoApiProvider.delete(id) ?? false;
    }
  }
}