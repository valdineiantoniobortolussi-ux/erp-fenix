import 'package:comissoes/app/infra/constants.dart';
import 'package:comissoes/app/data/provider/api/comissao_perfil_api_provider.dart';
import 'package:comissoes/app/data/provider/drift/comissao_perfil_drift_provider.dart';
import 'package:comissoes/app/data/model/model_imports.dart';

class ComissaoPerfilRepository {
  final ComissaoPerfilApiProvider comissaoPerfilApiProvider;
  final ComissaoPerfilDriftProvider comissaoPerfilDriftProvider;

  ComissaoPerfilRepository({required this.comissaoPerfilApiProvider, required this.comissaoPerfilDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await comissaoPerfilDriftProvider.getList(filter: filter);
    } else {
      return await comissaoPerfilApiProvider.getList(filter: filter);
    }
  }

  Future<ComissaoPerfilModel?>? save({required ComissaoPerfilModel comissaoPerfilModel}) async {
    if (comissaoPerfilModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await comissaoPerfilDriftProvider.update(comissaoPerfilModel);
      } else {
        return await comissaoPerfilApiProvider.update(comissaoPerfilModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await comissaoPerfilDriftProvider.insert(comissaoPerfilModel);
      } else {
        return await comissaoPerfilApiProvider.insert(comissaoPerfilModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await comissaoPerfilDriftProvider.delete(id) ?? false;
    } else {
      return await comissaoPerfilApiProvider.delete(id) ?? false;
    }
  }
}