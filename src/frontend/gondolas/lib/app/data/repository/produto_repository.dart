import 'package:gondolas/app/infra/constants.dart';
import 'package:gondolas/app/data/provider/api/produto_api_provider.dart';
import 'package:gondolas/app/data/provider/drift/produto_drift_provider.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class ProdutoRepository {
  final ProdutoApiProvider produtoApiProvider;
  final ProdutoDriftProvider produtoDriftProvider;

  ProdutoRepository({required this.produtoApiProvider, required this.produtoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoDriftProvider.getList(filter: filter);
    } else {
      return await produtoApiProvider.getList(filter: filter);
    }
  }

  Future<ProdutoModel?>? save({required ProdutoModel produtoModel}) async {
    if (produtoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await produtoDriftProvider.update(produtoModel);
      } else {
        return await produtoApiProvider.update(produtoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await produtoDriftProvider.insert(produtoModel);
      } else {
        return await produtoApiProvider.insert(produtoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoDriftProvider.delete(id) ?? false;
    } else {
      return await produtoApiProvider.delete(id) ?? false;
    }
  }
}