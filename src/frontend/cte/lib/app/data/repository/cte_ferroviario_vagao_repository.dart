import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_ferroviario_vagao_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_ferroviario_vagao_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteFerroviarioVagaoRepository {
  final CteFerroviarioVagaoApiProvider cteFerroviarioVagaoApiProvider;
  final CteFerroviarioVagaoDriftProvider cteFerroviarioVagaoDriftProvider;

  CteFerroviarioVagaoRepository({required this.cteFerroviarioVagaoApiProvider, required this.cteFerroviarioVagaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteFerroviarioVagaoDriftProvider.getList(filter: filter);
    } else {
      return await cteFerroviarioVagaoApiProvider.getList(filter: filter);
    }
  }

  Future<CteFerroviarioVagaoModel?>? save({required CteFerroviarioVagaoModel cteFerroviarioVagaoModel}) async {
    if (cteFerroviarioVagaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteFerroviarioVagaoDriftProvider.update(cteFerroviarioVagaoModel);
      } else {
        return await cteFerroviarioVagaoApiProvider.update(cteFerroviarioVagaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteFerroviarioVagaoDriftProvider.insert(cteFerroviarioVagaoModel);
      } else {
        return await cteFerroviarioVagaoApiProvider.insert(cteFerroviarioVagaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteFerroviarioVagaoDriftProvider.delete(id) ?? false;
    } else {
      return await cteFerroviarioVagaoApiProvider.delete(id) ?? false;
    }
  }
}