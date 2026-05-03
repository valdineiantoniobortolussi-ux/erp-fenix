import 'package:vendas/app/infra/constants.dart';
import 'package:vendas/app/data/provider/api/view_pessoa_transportadora_api_provider.dart';
import 'package:vendas/app/data/provider/drift/view_pessoa_transportadora_drift_provider.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class ViewPessoaTransportadoraRepository {
  final ViewPessoaTransportadoraApiProvider viewPessoaTransportadoraApiProvider;
  final ViewPessoaTransportadoraDriftProvider viewPessoaTransportadoraDriftProvider;

  ViewPessoaTransportadoraRepository({required this.viewPessoaTransportadoraApiProvider, required this.viewPessoaTransportadoraDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaTransportadoraDriftProvider.getList(filter: filter);
    } else {
      return await viewPessoaTransportadoraApiProvider.getList(filter: filter);
    }
  }

  Future<ViewPessoaTransportadoraModel?>? save({required ViewPessoaTransportadoraModel viewPessoaTransportadoraModel}) async {
    if (viewPessoaTransportadoraModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaTransportadoraDriftProvider.update(viewPessoaTransportadoraModel);
      } else {
        return await viewPessoaTransportadoraApiProvider.update(viewPessoaTransportadoraModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaTransportadoraDriftProvider.insert(viewPessoaTransportadoraModel);
      } else {
        return await viewPessoaTransportadoraApiProvider.insert(viewPessoaTransportadoraModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaTransportadoraDriftProvider.delete(id) ?? false;
    } else {
      return await viewPessoaTransportadoraApiProvider.delete(id) ?? false;
    }
  }
}