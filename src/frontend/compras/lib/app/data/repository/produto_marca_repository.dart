import 'package:compras/app/infra/constants.dart';
import 'package:compras/app/data/provider/api/produto_marca_api_provider.dart';
import 'package:compras/app/data/provider/drift/produto_marca_drift_provider.dart';
import 'package:compras/app/data/model/model_imports.dart';

class ProdutoMarcaRepository {
  final ProdutoMarcaApiProvider produtoMarcaApiProvider;
  final ProdutoMarcaDriftProvider produtoMarcaDriftProvider;

  ProdutoMarcaRepository({required this.produtoMarcaApiProvider, required this.produtoMarcaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoMarcaDriftProvider.getList(filter: filter);
    } else {
      return await produtoMarcaApiProvider.getList(filter: filter);
    }
  }

  Future<ProdutoMarcaModel?>? save({required ProdutoMarcaModel produtoMarcaModel}) async {
    if (produtoMarcaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await produtoMarcaDriftProvider.update(produtoMarcaModel);
      } else {
        return await produtoMarcaApiProvider.update(produtoMarcaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await produtoMarcaDriftProvider.insert(produtoMarcaModel);
      } else {
        return await produtoMarcaApiProvider.insert(produtoMarcaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoMarcaDriftProvider.delete(id) ?? false;
    } else {
      return await produtoMarcaApiProvider.delete(id) ?? false;
    }
  }
}