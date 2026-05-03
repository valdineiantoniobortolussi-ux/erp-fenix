import 'package:orcamentos/app/infra/constants.dart';
import 'package:orcamentos/app/data/provider/api/orcamento_periodo_api_provider.dart';
import 'package:orcamentos/app/data/provider/drift/orcamento_periodo_drift_provider.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoPeriodoRepository {
  final OrcamentoPeriodoApiProvider orcamentoPeriodoApiProvider;
  final OrcamentoPeriodoDriftProvider orcamentoPeriodoDriftProvider;

  OrcamentoPeriodoRepository({required this.orcamentoPeriodoApiProvider, required this.orcamentoPeriodoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await orcamentoPeriodoDriftProvider.getList(filter: filter);
    } else {
      return await orcamentoPeriodoApiProvider.getList(filter: filter);
    }
  }

  Future<OrcamentoPeriodoModel?>? save({required OrcamentoPeriodoModel orcamentoPeriodoModel}) async {
    if (orcamentoPeriodoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await orcamentoPeriodoDriftProvider.update(orcamentoPeriodoModel);
      } else {
        return await orcamentoPeriodoApiProvider.update(orcamentoPeriodoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await orcamentoPeriodoDriftProvider.insert(orcamentoPeriodoModel);
      } else {
        return await orcamentoPeriodoApiProvider.insert(orcamentoPeriodoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await orcamentoPeriodoDriftProvider.delete(id) ?? false;
    } else {
      return await orcamentoPeriodoApiProvider.delete(id) ?? false;
    }
  }
}