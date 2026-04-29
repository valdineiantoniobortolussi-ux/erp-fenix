import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_lancamento_comissao_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_lancamento_comissao_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaLancamentoComissaoRepository {
  final FolhaLancamentoComissaoApiProvider folhaLancamentoComissaoApiProvider;
  final FolhaLancamentoComissaoDriftProvider folhaLancamentoComissaoDriftProvider;

  FolhaLancamentoComissaoRepository({required this.folhaLancamentoComissaoApiProvider, required this.folhaLancamentoComissaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaLancamentoComissaoDriftProvider.getList(filter: filter);
    } else {
      return await folhaLancamentoComissaoApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaLancamentoComissaoModel?>? save({required FolhaLancamentoComissaoModel folhaLancamentoComissaoModel}) async {
    if (folhaLancamentoComissaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaLancamentoComissaoDriftProvider.update(folhaLancamentoComissaoModel);
      } else {
        return await folhaLancamentoComissaoApiProvider.update(folhaLancamentoComissaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaLancamentoComissaoDriftProvider.insert(folhaLancamentoComissaoModel);
      } else {
        return await folhaLancamentoComissaoApiProvider.insert(folhaLancamentoComissaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaLancamentoComissaoDriftProvider.delete(id) ?? false;
    } else {
      return await folhaLancamentoComissaoApiProvider.delete(id) ?? false;
    }
  }
}