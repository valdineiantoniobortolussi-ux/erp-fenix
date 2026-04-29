import 'package:frotas/app/infra/constants.dart';
import 'package:frotas/app/data/provider/api/frota_motorista_api_provider.dart';
import 'package:frotas/app/data/provider/drift/frota_motorista_drift_provider.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaMotoristaRepository {
  final FrotaMotoristaApiProvider frotaMotoristaApiProvider;
  final FrotaMotoristaDriftProvider frotaMotoristaDriftProvider;

  FrotaMotoristaRepository({required this.frotaMotoristaApiProvider, required this.frotaMotoristaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await frotaMotoristaDriftProvider.getList(filter: filter);
    } else {
      return await frotaMotoristaApiProvider.getList(filter: filter);
    }
  }

  Future<FrotaMotoristaModel?>? save({required FrotaMotoristaModel frotaMotoristaModel}) async {
    if (frotaMotoristaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await frotaMotoristaDriftProvider.update(frotaMotoristaModel);
      } else {
        return await frotaMotoristaApiProvider.update(frotaMotoristaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await frotaMotoristaDriftProvider.insert(frotaMotoristaModel);
      } else {
        return await frotaMotoristaApiProvider.insert(frotaMotoristaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await frotaMotoristaDriftProvider.delete(id) ?? false;
    } else {
      return await frotaMotoristaApiProvider.delete(id) ?? false;
    }
  }
}