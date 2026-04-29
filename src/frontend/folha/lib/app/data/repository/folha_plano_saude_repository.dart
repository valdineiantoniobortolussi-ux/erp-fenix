import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_plano_saude_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_plano_saude_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaPlanoSaudeRepository {
  final FolhaPlanoSaudeApiProvider folhaPlanoSaudeApiProvider;
  final FolhaPlanoSaudeDriftProvider folhaPlanoSaudeDriftProvider;

  FolhaPlanoSaudeRepository({required this.folhaPlanoSaudeApiProvider, required this.folhaPlanoSaudeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaPlanoSaudeDriftProvider.getList(filter: filter);
    } else {
      return await folhaPlanoSaudeApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaPlanoSaudeModel?>? save({required FolhaPlanoSaudeModel folhaPlanoSaudeModel}) async {
    if (folhaPlanoSaudeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaPlanoSaudeDriftProvider.update(folhaPlanoSaudeModel);
      } else {
        return await folhaPlanoSaudeApiProvider.update(folhaPlanoSaudeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaPlanoSaudeDriftProvider.insert(folhaPlanoSaudeModel);
      } else {
        return await folhaPlanoSaudeApiProvider.insert(folhaPlanoSaudeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaPlanoSaudeDriftProvider.delete(id) ?? false;
    } else {
      return await folhaPlanoSaudeApiProvider.delete(id) ?? false;
    }
  }
}