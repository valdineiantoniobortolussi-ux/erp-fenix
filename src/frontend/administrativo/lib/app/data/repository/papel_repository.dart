import 'package:administrativo/app/infra/constants.dart';
import 'package:administrativo/app/data/provider/api/papel_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/papel_drift_provider.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class PapelRepository {
  final PapelApiProvider papelApiProvider;
  final PapelDriftProvider papelDriftProvider;

  PapelRepository({required this.papelApiProvider, required this.papelDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await papelDriftProvider.getList(filter: filter);
    } else {
      return await papelApiProvider.getList(filter: filter);
    }
  }

  Future<PapelModel?>? save({required PapelModel papelModel}) async {
    if (papelModel.id != null) {
      if (Constants.usingLocalDatabase) {
        return await papelDriftProvider.update(papelModel);
      } else {
        return await papelApiProvider.update(papelModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await papelDriftProvider.insert(papelModel);
      } else {
        return await papelApiProvider.insert(papelModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await papelDriftProvider.delete(id) ?? false;
    } else {
      return await papelApiProvider.delete(id) ?? false;
    }
  }
}