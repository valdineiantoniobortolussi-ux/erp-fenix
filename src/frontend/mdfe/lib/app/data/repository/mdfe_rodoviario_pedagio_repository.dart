import 'package:mdfe/app/infra/constants.dart';
import 'package:mdfe/app/data/provider/api/mdfe_rodoviario_pedagio_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_rodoviario_pedagio_drift_provider.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioPedagioRepository {
  final MdfeRodoviarioPedagioApiProvider mdfeRodoviarioPedagioApiProvider;
  final MdfeRodoviarioPedagioDriftProvider mdfeRodoviarioPedagioDriftProvider;

  MdfeRodoviarioPedagioRepository({required this.mdfeRodoviarioPedagioApiProvider, required this.mdfeRodoviarioPedagioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeRodoviarioPedagioDriftProvider.getList(filter: filter);
    } else {
      return await mdfeRodoviarioPedagioApiProvider.getList(filter: filter);
    }
  }

  Future<MdfeRodoviarioPedagioModel?>? save({required MdfeRodoviarioPedagioModel mdfeRodoviarioPedagioModel}) async {
    if (mdfeRodoviarioPedagioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await mdfeRodoviarioPedagioDriftProvider.update(mdfeRodoviarioPedagioModel);
      } else {
        return await mdfeRodoviarioPedagioApiProvider.update(mdfeRodoviarioPedagioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await mdfeRodoviarioPedagioDriftProvider.insert(mdfeRodoviarioPedagioModel);
      } else {
        return await mdfeRodoviarioPedagioApiProvider.insert(mdfeRodoviarioPedagioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeRodoviarioPedagioDriftProvider.delete(id) ?? false;
    } else {
      return await mdfeRodoviarioPedagioApiProvider.delete(id) ?? false;
    }
  }
}