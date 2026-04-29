import 'package:tributacao/app/infra/constants.dart';
import 'package:tributacao/app/data/provider/api/tribut_grupo_tributario_api_provider.dart';
import 'package:tributacao/app/data/provider/drift/tribut_grupo_tributario_drift_provider.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributGrupoTributarioRepository {
  final TributGrupoTributarioApiProvider tributGrupoTributarioApiProvider;
  final TributGrupoTributarioDriftProvider tributGrupoTributarioDriftProvider;

  TributGrupoTributarioRepository({required this.tributGrupoTributarioApiProvider, required this.tributGrupoTributarioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tributGrupoTributarioDriftProvider.getList(filter: filter);
    } else {
      return await tributGrupoTributarioApiProvider.getList(filter: filter);
    }
  }

  Future<TributGrupoTributarioModel?>? save({required TributGrupoTributarioModel tributGrupoTributarioModel}) async {
    if (tributGrupoTributarioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tributGrupoTributarioDriftProvider.update(tributGrupoTributarioModel);
      } else {
        return await tributGrupoTributarioApiProvider.update(tributGrupoTributarioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tributGrupoTributarioDriftProvider.insert(tributGrupoTributarioModel);
      } else {
        return await tributGrupoTributarioApiProvider.insert(tributGrupoTributarioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tributGrupoTributarioDriftProvider.delete(id) ?? false;
    } else {
      return await tributGrupoTributarioApiProvider.delete(id) ?? false;
    }
  }
}