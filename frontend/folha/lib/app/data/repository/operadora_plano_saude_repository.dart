import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/operadora_plano_saude_api_provider.dart';
import 'package:folha/app/data/provider/drift/operadora_plano_saude_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class OperadoraPlanoSaudeRepository {
  final OperadoraPlanoSaudeApiProvider operadoraPlanoSaudeApiProvider;
  final OperadoraPlanoSaudeDriftProvider operadoraPlanoSaudeDriftProvider;

  OperadoraPlanoSaudeRepository({required this.operadoraPlanoSaudeApiProvider, required this.operadoraPlanoSaudeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await operadoraPlanoSaudeDriftProvider.getList(filter: filter);
    } else {
      return await operadoraPlanoSaudeApiProvider.getList(filter: filter);
    }
  }

  Future<OperadoraPlanoSaudeModel?>? save({required OperadoraPlanoSaudeModel operadoraPlanoSaudeModel}) async {
    if (operadoraPlanoSaudeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await operadoraPlanoSaudeDriftProvider.update(operadoraPlanoSaudeModel);
      } else {
        return await operadoraPlanoSaudeApiProvider.update(operadoraPlanoSaudeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await operadoraPlanoSaudeDriftProvider.insert(operadoraPlanoSaudeModel);
      } else {
        return await operadoraPlanoSaudeApiProvider.insert(operadoraPlanoSaudeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await operadoraPlanoSaudeDriftProvider.delete(id) ?? false;
    } else {
      return await operadoraPlanoSaudeApiProvider.delete(id) ?? false;
    }
  }
}