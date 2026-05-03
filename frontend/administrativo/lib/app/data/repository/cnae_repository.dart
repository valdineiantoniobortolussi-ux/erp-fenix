import 'package:administrativo/app/infra/constants.dart';
import 'package:administrativo/app/data/provider/api/cnae_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/cnae_drift_provider.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class CnaeRepository {
  final CnaeApiProvider cnaeApiProvider;
  final CnaeDriftProvider cnaeDriftProvider;

  CnaeRepository({required this.cnaeApiProvider, required this.cnaeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cnaeDriftProvider.getList(filter: filter);
    } else {
      return await cnaeApiProvider.getList(filter: filter);
    }
  }

  Future<CnaeModel?>? save({required CnaeModel cnaeModel}) async {
    if (cnaeModel.id != null) {
      if (Constants.usingLocalDatabase) {
        return await cnaeDriftProvider.update(cnaeModel);
      } else {
        return await cnaeApiProvider.update(cnaeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cnaeDriftProvider.insert(cnaeModel);
      } else {
        return await cnaeApiProvider.insert(cnaeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cnaeDriftProvider.delete(id) ?? false;
    } else {
      return await cnaeApiProvider.delete(id) ?? false;
    }
  }
}