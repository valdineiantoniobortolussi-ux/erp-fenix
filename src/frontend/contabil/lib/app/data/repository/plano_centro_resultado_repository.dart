import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/plano_centro_resultado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/plano_centro_resultado_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class PlanoCentroResultadoRepository {
  final PlanoCentroResultadoApiProvider planoCentroResultadoApiProvider;
  final PlanoCentroResultadoDriftProvider planoCentroResultadoDriftProvider;

  PlanoCentroResultadoRepository({required this.planoCentroResultadoApiProvider, required this.planoCentroResultadoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await planoCentroResultadoDriftProvider.getList(filter: filter);
    } else {
      return await planoCentroResultadoApiProvider.getList(filter: filter);
    }
  }

  Future<PlanoCentroResultadoModel?>? save({required PlanoCentroResultadoModel planoCentroResultadoModel}) async {
    if (planoCentroResultadoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await planoCentroResultadoDriftProvider.update(planoCentroResultadoModel);
      } else {
        return await planoCentroResultadoApiProvider.update(planoCentroResultadoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await planoCentroResultadoDriftProvider.insert(planoCentroResultadoModel);
      } else {
        return await planoCentroResultadoApiProvider.insert(planoCentroResultadoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await planoCentroResultadoDriftProvider.delete(id) ?? false;
    } else {
      return await planoCentroResultadoApiProvider.delete(id) ?? false;
    }
  }
}