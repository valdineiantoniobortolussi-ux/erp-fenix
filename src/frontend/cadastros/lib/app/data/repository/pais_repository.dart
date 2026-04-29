import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/pais_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/pais_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class PaisRepository {
  final PaisApiProvider paisApiProvider;
  final PaisDriftProvider paisDriftProvider;

  PaisRepository({required this.paisApiProvider, required this.paisDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await paisDriftProvider.getList(filter: filter);
    } else {
      return await paisApiProvider.getList(filter: filter);
    }
  }

  Future<PaisModel?>? save({required PaisModel paisModel}) async {
    if (paisModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await paisDriftProvider.update(paisModel);
      } else {
        return await paisApiProvider.update(paisModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await paisDriftProvider.insert(paisModel);
      } else {
        return await paisApiProvider.insert(paisModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await paisDriftProvider.delete(id) ?? false;
    } else {
      return await paisApiProvider.delete(id) ?? false;
    }
  }
}