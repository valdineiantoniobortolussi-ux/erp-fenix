import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_fechamento_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_fechamento_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaFechamentoRepository {
  final FolhaFechamentoApiProvider folhaFechamentoApiProvider;
  final FolhaFechamentoDriftProvider folhaFechamentoDriftProvider;

  FolhaFechamentoRepository({required this.folhaFechamentoApiProvider, required this.folhaFechamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaFechamentoDriftProvider.getList(filter: filter);
    } else {
      return await folhaFechamentoApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaFechamentoModel?>? save({required FolhaFechamentoModel folhaFechamentoModel}) async {
    if (folhaFechamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaFechamentoDriftProvider.update(folhaFechamentoModel);
      } else {
        return await folhaFechamentoApiProvider.update(folhaFechamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaFechamentoDriftProvider.insert(folhaFechamentoModel);
      } else {
        return await folhaFechamentoApiProvider.insert(folhaFechamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaFechamentoDriftProvider.delete(id) ?? false;
    } else {
      return await folhaFechamentoApiProvider.delete(id) ?? false;
    }
  }
}