import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/view_controle_acesso_api_provider.dart';
import 'package:nfe/app/data/provider/drift/view_controle_acesso_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewControleAcessoRepository {
  final ViewControleAcessoApiProvider viewControleAcessoApiProvider;
  final ViewControleAcessoDriftProvider viewControleAcessoDriftProvider;

  ViewControleAcessoRepository({required this.viewControleAcessoApiProvider, required this.viewControleAcessoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await viewControleAcessoDriftProvider.getList(filter: filter);
    } else {
      return await viewControleAcessoApiProvider.getList(filter: filter);
    }
  }

  Future<ViewControleAcessoModel?>? save({required ViewControleAcessoModel viewControleAcessoModel}) async {
    if (viewControleAcessoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await viewControleAcessoDriftProvider.update(viewControleAcessoModel);
      } else {
        return await viewControleAcessoApiProvider.update(viewControleAcessoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await viewControleAcessoDriftProvider.insert(viewControleAcessoModel);
      } else {
        return await viewControleAcessoApiProvider.insert(viewControleAcessoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await viewControleAcessoDriftProvider.delete(id) ?? false;
    } else {
      return await viewControleAcessoApiProvider.delete(id) ?? false;
    }
  }
}