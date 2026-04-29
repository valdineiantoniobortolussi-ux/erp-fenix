import 'package:agenda/app/infra/constants.dart';
import 'package:agenda/app/data/provider/api/recado_remetente_api_provider.dart';
import 'package:agenda/app/data/provider/drift/recado_remetente_drift_provider.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class RecadoRemetenteRepository {
  final RecadoRemetenteApiProvider recadoRemetenteApiProvider;
  final RecadoRemetenteDriftProvider recadoRemetenteDriftProvider;

  RecadoRemetenteRepository({required this.recadoRemetenteApiProvider, required this.recadoRemetenteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await recadoRemetenteDriftProvider.getList(filter: filter);
    } else {
      return await recadoRemetenteApiProvider.getList(filter: filter);
    }
  }

  Future<RecadoRemetenteModel?>? save({required RecadoRemetenteModel recadoRemetenteModel}) async {
    if (recadoRemetenteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await recadoRemetenteDriftProvider.update(recadoRemetenteModel);
      } else {
        return await recadoRemetenteApiProvider.update(recadoRemetenteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await recadoRemetenteDriftProvider.insert(recadoRemetenteModel);
      } else {
        return await recadoRemetenteApiProvider.insert(recadoRemetenteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await recadoRemetenteDriftProvider.delete(id) ?? false;
    } else {
      return await recadoRemetenteApiProvider.delete(id) ?? false;
    }
  }
}