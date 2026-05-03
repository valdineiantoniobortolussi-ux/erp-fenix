import 'package:mdfe/app/infra/constants.dart';
import 'package:mdfe/app/data/provider/api/mdfe_rodoviario_motorista_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_rodoviario_motorista_drift_provider.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioMotoristaRepository {
  final MdfeRodoviarioMotoristaApiProvider mdfeRodoviarioMotoristaApiProvider;
  final MdfeRodoviarioMotoristaDriftProvider mdfeRodoviarioMotoristaDriftProvider;

  MdfeRodoviarioMotoristaRepository({required this.mdfeRodoviarioMotoristaApiProvider, required this.mdfeRodoviarioMotoristaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeRodoviarioMotoristaDriftProvider.getList(filter: filter);
    } else {
      return await mdfeRodoviarioMotoristaApiProvider.getList(filter: filter);
    }
  }

  Future<MdfeRodoviarioMotoristaModel?>? save({required MdfeRodoviarioMotoristaModel mdfeRodoviarioMotoristaModel}) async {
    if (mdfeRodoviarioMotoristaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await mdfeRodoviarioMotoristaDriftProvider.update(mdfeRodoviarioMotoristaModel);
      } else {
        return await mdfeRodoviarioMotoristaApiProvider.update(mdfeRodoviarioMotoristaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await mdfeRodoviarioMotoristaDriftProvider.insert(mdfeRodoviarioMotoristaModel);
      } else {
        return await mdfeRodoviarioMotoristaApiProvider.insert(mdfeRodoviarioMotoristaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeRodoviarioMotoristaDriftProvider.delete(id) ?? false;
    } else {
      return await mdfeRodoviarioMotoristaApiProvider.delete(id) ?? false;
    }
  }
}