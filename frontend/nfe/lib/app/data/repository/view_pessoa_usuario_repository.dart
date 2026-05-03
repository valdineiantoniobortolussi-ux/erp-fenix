import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/view_pessoa_usuario_api_provider.dart';
import 'package:nfe/app/data/provider/drift/view_pessoa_usuario_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewPessoaUsuarioRepository {
  final ViewPessoaUsuarioApiProvider viewPessoaUsuarioApiProvider;
  final ViewPessoaUsuarioDriftProvider viewPessoaUsuarioDriftProvider;

  ViewPessoaUsuarioRepository({required this.viewPessoaUsuarioApiProvider, required this.viewPessoaUsuarioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaUsuarioDriftProvider.getList(filter: filter);
    } else {
      return await viewPessoaUsuarioApiProvider.getList(filter: filter);
    }
  }

  Future<ViewPessoaUsuarioModel?>? save({required ViewPessoaUsuarioModel viewPessoaUsuarioModel}) async {
    if (viewPessoaUsuarioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaUsuarioDriftProvider.update(viewPessoaUsuarioModel);
      } else {
        return await viewPessoaUsuarioApiProvider.update(viewPessoaUsuarioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaUsuarioDriftProvider.insert(viewPessoaUsuarioModel);
      } else {
        return await viewPessoaUsuarioApiProvider.insert(viewPessoaUsuarioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaUsuarioDriftProvider.delete(id) ?? false;
    } else {
      return await viewPessoaUsuarioApiProvider.delete(id) ?? false;
    }
  }

  Future<ViewPessoaUsuarioModel?>? doLogin({required ViewPessoaUsuarioModel viewPessoaUsuarioModel}) async {
    return await viewPessoaUsuarioApiProvider.doLogin(viewPessoaUsuarioModel);
  }  
}