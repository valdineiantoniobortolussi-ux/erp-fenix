import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_lancamento_cabecalho_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_lancamento_cabecalho_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaLancamentoCabecalhoRepository {
  final FolhaLancamentoCabecalhoApiProvider folhaLancamentoCabecalhoApiProvider;
  final FolhaLancamentoCabecalhoDriftProvider folhaLancamentoCabecalhoDriftProvider;

  FolhaLancamentoCabecalhoRepository({required this.folhaLancamentoCabecalhoApiProvider, required this.folhaLancamentoCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaLancamentoCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await folhaLancamentoCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaLancamentoCabecalhoModel?>? save({required FolhaLancamentoCabecalhoModel folhaLancamentoCabecalhoModel}) async {
    if (folhaLancamentoCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaLancamentoCabecalhoDriftProvider.update(folhaLancamentoCabecalhoModel);
      } else {
        return await folhaLancamentoCabecalhoApiProvider.update(folhaLancamentoCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaLancamentoCabecalhoDriftProvider.insert(folhaLancamentoCabecalhoModel);
      } else {
        return await folhaLancamentoCabecalhoApiProvider.insert(folhaLancamentoCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaLancamentoCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await folhaLancamentoCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}