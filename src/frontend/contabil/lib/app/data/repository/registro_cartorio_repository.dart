import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/registro_cartorio_api_provider.dart';
import 'package:contabil/app/data/provider/drift/registro_cartorio_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class RegistroCartorioRepository {
  final RegistroCartorioApiProvider registroCartorioApiProvider;
  final RegistroCartorioDriftProvider registroCartorioDriftProvider;

  RegistroCartorioRepository({required this.registroCartorioApiProvider, required this.registroCartorioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await registroCartorioDriftProvider.getList(filter: filter);
    } else {
      return await registroCartorioApiProvider.getList(filter: filter);
    }
  }

  Future<RegistroCartorioModel?>? save({required RegistroCartorioModel registroCartorioModel}) async {
    if (registroCartorioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await registroCartorioDriftProvider.update(registroCartorioModel);
      } else {
        return await registroCartorioApiProvider.update(registroCartorioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await registroCartorioDriftProvider.insert(registroCartorioModel);
      } else {
        return await registroCartorioApiProvider.insert(registroCartorioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await registroCartorioDriftProvider.delete(id) ?? false;
    } else {
      return await registroCartorioApiProvider.delete(id) ?? false;
    }
  }
}