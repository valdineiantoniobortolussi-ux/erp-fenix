import 'package:orcamentos/app/infra/constants.dart';
import 'package:orcamentos/app/data/provider/api/orcamento_fluxo_caixa_periodo_api_provider.dart';
import 'package:orcamentos/app/data/provider/drift/orcamento_fluxo_caixa_periodo_drift_provider.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoFluxoCaixaPeriodoRepository {
  final OrcamentoFluxoCaixaPeriodoApiProvider orcamentoFluxoCaixaPeriodoApiProvider;
  final OrcamentoFluxoCaixaPeriodoDriftProvider orcamentoFluxoCaixaPeriodoDriftProvider;

  OrcamentoFluxoCaixaPeriodoRepository({required this.orcamentoFluxoCaixaPeriodoApiProvider, required this.orcamentoFluxoCaixaPeriodoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await orcamentoFluxoCaixaPeriodoDriftProvider.getList(filter: filter);
    } else {
      return await orcamentoFluxoCaixaPeriodoApiProvider.getList(filter: filter);
    }
  }

  Future<OrcamentoFluxoCaixaPeriodoModel?>? save({required OrcamentoFluxoCaixaPeriodoModel orcamentoFluxoCaixaPeriodoModel}) async {
    if (orcamentoFluxoCaixaPeriodoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await orcamentoFluxoCaixaPeriodoDriftProvider.update(orcamentoFluxoCaixaPeriodoModel);
      } else {
        return await orcamentoFluxoCaixaPeriodoApiProvider.update(orcamentoFluxoCaixaPeriodoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await orcamentoFluxoCaixaPeriodoDriftProvider.insert(orcamentoFluxoCaixaPeriodoModel);
      } else {
        return await orcamentoFluxoCaixaPeriodoApiProvider.insert(orcamentoFluxoCaixaPeriodoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await orcamentoFluxoCaixaPeriodoDriftProvider.delete(id) ?? false;
    } else {
      return await orcamentoFluxoCaixaPeriodoApiProvider.delete(id) ?? false;
    }
  }
}