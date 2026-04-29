import 'package:estoque/app/infra/constants.dart';
import 'package:estoque/app/data/provider/api/produto_subgrupo_api_provider.dart';
import 'package:estoque/app/data/provider/drift/produto_subgrupo_drift_provider.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class ProdutoSubgrupoRepository {
  final ProdutoSubgrupoApiProvider produtoSubgrupoApiProvider;
  final ProdutoSubgrupoDriftProvider produtoSubgrupoDriftProvider;

  ProdutoSubgrupoRepository({required this.produtoSubgrupoApiProvider, required this.produtoSubgrupoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoSubgrupoDriftProvider.getList(filter: filter);
    } else {
      return await produtoSubgrupoApiProvider.getList(filter: filter);
    }
  }

  Future<ProdutoSubgrupoModel?>? save({required ProdutoSubgrupoModel produtoSubgrupoModel}) async {
    if (produtoSubgrupoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await produtoSubgrupoDriftProvider.update(produtoSubgrupoModel);
      } else {
        return await produtoSubgrupoApiProvider.update(produtoSubgrupoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await produtoSubgrupoDriftProvider.insert(produtoSubgrupoModel);
      } else {
        return await produtoSubgrupoApiProvider.insert(produtoSubgrupoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoSubgrupoDriftProvider.delete(id) ?? false;
    } else {
      return await produtoSubgrupoApiProvider.delete(id) ?? false;
    }
  }
}