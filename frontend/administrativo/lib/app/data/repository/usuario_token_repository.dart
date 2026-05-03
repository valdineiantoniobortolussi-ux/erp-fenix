import 'package:administrativo/app/infra/constants.dart';
import 'package:administrativo/app/data/provider/api/usuario_token_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/usuario_token_drift_provider.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class UsuarioTokenRepository {
  final UsuarioTokenApiProvider usuarioTokenApiProvider;
  final UsuarioTokenDriftProvider usuarioTokenDriftProvider;

  UsuarioTokenRepository({required this.usuarioTokenApiProvider, required this.usuarioTokenDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await usuarioTokenDriftProvider.getList(filter: filter);
    } else {
      return await usuarioTokenApiProvider.getList(filter: filter);
    }
  }

  Future<UsuarioTokenModel?>? save({required UsuarioTokenModel usuarioTokenModel}) async {
    if (usuarioTokenModel.id != null) {
      if (Constants.usingLocalDatabase) {
        return await usuarioTokenDriftProvider.update(usuarioTokenModel);
      } else {
        return await usuarioTokenApiProvider.update(usuarioTokenModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await usuarioTokenDriftProvider.insert(usuarioTokenModel);
      } else {
        return await usuarioTokenApiProvider.insert(usuarioTokenModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await usuarioTokenDriftProvider.delete(id) ?? false;
    } else {
      return await usuarioTokenApiProvider.delete(id) ?? false;
    }
  }
}