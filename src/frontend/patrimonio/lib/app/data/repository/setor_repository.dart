import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/setor_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/setor_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class SetorRepository {
  final SetorApiProvider setorApiProvider;
  final SetorDriftProvider setorDriftProvider;

  SetorRepository({required this.setorApiProvider, required this.setorDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await setorDriftProvider.getList(filter: filter);
    } else {
      return await setorApiProvider.getList(filter: filter);
    }
  }

  Future<SetorModel?>? save({required SetorModel setorModel}) async {
    if (setorModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await setorDriftProvider.update(setorModel);
      } else {
        return await setorApiProvider.update(setorModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await setorDriftProvider.insert(setorModel);
      } else {
        return await setorApiProvider.insert(setorModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await setorDriftProvider.delete(id) ?? false;
    } else {
      return await setorApiProvider.delete(id) ?? false;
    }
  }
}