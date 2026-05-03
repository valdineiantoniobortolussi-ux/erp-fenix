import 'package:ordem_servico/app/infra/constants.dart';
import 'package:ordem_servico/app/data/provider/api/produto_grupo_api_provider.dart';
import 'package:ordem_servico/app/data/provider/drift/produto_grupo_drift_provider.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class ProdutoGrupoRepository {
  final ProdutoGrupoApiProvider produtoGrupoApiProvider;
  final ProdutoGrupoDriftProvider produtoGrupoDriftProvider;

  ProdutoGrupoRepository({required this.produtoGrupoApiProvider, required this.produtoGrupoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoGrupoDriftProvider.getList(filter: filter);
    } else {
      return await produtoGrupoApiProvider.getList(filter: filter);
    }
  }

  Future<ProdutoGrupoModel?>? save({required ProdutoGrupoModel produtoGrupoModel}) async {
    if (produtoGrupoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await produtoGrupoDriftProvider.update(produtoGrupoModel);
      } else {
        return await produtoGrupoApiProvider.update(produtoGrupoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await produtoGrupoDriftProvider.insert(produtoGrupoModel);
      } else {
        return await produtoGrupoApiProvider.insert(produtoGrupoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await produtoGrupoDriftProvider.delete(id) ?? false;
    } else {
      return await produtoGrupoApiProvider.delete(id) ?? false;
    }
  }
}