import 'package:vendas/app/infra/constants.dart';
import 'package:vendas/app/data/provider/api/produto_unidade_api_provider.dart';
import 'package:vendas/app/data/provider/drift/produto_unidade_drift_provider.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class ProdutoUnidadeRepository {
  final ProdutoUnidadeApiProvider produtoUnidadeApiProvider;
  final ProdutoUnidadeDriftProvider produtoUnidadeDriftProvider;

  ProdutoUnidadeRepository({required this.produtoUnidadeApiProvider, required this.produtoUnidadeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoUnidadeDriftProvider.getList(filter: filter);
    } else {
      return await produtoUnidadeApiProvider.getList(filter: filter);
    }
  }

  Future<ProdutoUnidadeModel?>? save({required ProdutoUnidadeModel produtoUnidadeModel}) async {
    if (produtoUnidadeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await produtoUnidadeDriftProvider.update(produtoUnidadeModel);
      } else {
        return await produtoUnidadeApiProvider.update(produtoUnidadeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await produtoUnidadeDriftProvider.insert(produtoUnidadeModel);
      } else {
        return await produtoUnidadeApiProvider.insert(produtoUnidadeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoUnidadeDriftProvider.delete(id) ?? false;
    } else {
      return await produtoUnidadeApiProvider.delete(id) ?? false;
    }
  }
}