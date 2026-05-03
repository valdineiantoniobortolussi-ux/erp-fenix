import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/aidf_aimdf_api_provider.dart';
import 'package:contabil/app/data/provider/drift/aidf_aimdf_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class AidfAimdfRepository {
  final AidfAimdfApiProvider aidfAimdfApiProvider;
  final AidfAimdfDriftProvider aidfAimdfDriftProvider;

  AidfAimdfRepository({required this.aidfAimdfApiProvider, required this.aidfAimdfDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await aidfAimdfDriftProvider.getList(filter: filter);
    } else {
      return await aidfAimdfApiProvider.getList(filter: filter);
    }
  }

  Future<AidfAimdfModel?>? save({required AidfAimdfModel aidfAimdfModel}) async {
    if (aidfAimdfModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await aidfAimdfDriftProvider.update(aidfAimdfModel);
      } else {
        return await aidfAimdfApiProvider.update(aidfAimdfModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await aidfAimdfDriftProvider.insert(aidfAimdfModel);
      } else {
        return await aidfAimdfApiProvider.insert(aidfAimdfModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await aidfAimdfDriftProvider.delete(id) ?? false;
    } else {
      return await aidfAimdfApiProvider.delete(id) ?? false;
    }
  }
}