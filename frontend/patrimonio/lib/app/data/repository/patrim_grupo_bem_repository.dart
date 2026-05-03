import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/patrim_grupo_bem_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_grupo_bem_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimGrupoBemRepository {
  final PatrimGrupoBemApiProvider patrimGrupoBemApiProvider;
  final PatrimGrupoBemDriftProvider patrimGrupoBemDriftProvider;

  PatrimGrupoBemRepository({required this.patrimGrupoBemApiProvider, required this.patrimGrupoBemDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimGrupoBemDriftProvider.getList(filter: filter);
    } else {
      return await patrimGrupoBemApiProvider.getList(filter: filter);
    }
  }

  Future<PatrimGrupoBemModel?>? save({required PatrimGrupoBemModel patrimGrupoBemModel}) async {
    if (patrimGrupoBemModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await patrimGrupoBemDriftProvider.update(patrimGrupoBemModel);
      } else {
        return await patrimGrupoBemApiProvider.update(patrimGrupoBemModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await patrimGrupoBemDriftProvider.insert(patrimGrupoBemModel);
      } else {
        return await patrimGrupoBemApiProvider.insert(patrimGrupoBemModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimGrupoBemDriftProvider.delete(id) ?? false;
    } else {
      return await patrimGrupoBemApiProvider.delete(id) ?? false;
    }
  }
}