import 'package:orcamentos/app/infra/constants.dart';
import 'package:orcamentos/app/data/provider/api/orcamento_fluxo_caixa_api_provider.dart';
import 'package:orcamentos/app/data/provider/drift/orcamento_fluxo_caixa_drift_provider.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoFluxoCaixaRepository {
  final OrcamentoFluxoCaixaApiProvider orcamentoFluxoCaixaApiProvider;
  final OrcamentoFluxoCaixaDriftProvider orcamentoFluxoCaixaDriftProvider;

  OrcamentoFluxoCaixaRepository({required this.orcamentoFluxoCaixaApiProvider, required this.orcamentoFluxoCaixaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await orcamentoFluxoCaixaDriftProvider.getList(filter: filter);
    } else {
      return await orcamentoFluxoCaixaApiProvider.getList(filter: filter);
    }
  }

  Future<OrcamentoFluxoCaixaModel?>? save({required OrcamentoFluxoCaixaModel orcamentoFluxoCaixaModel}) async {
    if (orcamentoFluxoCaixaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await orcamentoFluxoCaixaDriftProvider.update(orcamentoFluxoCaixaModel);
      } else {
        return await orcamentoFluxoCaixaApiProvider.update(orcamentoFluxoCaixaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await orcamentoFluxoCaixaDriftProvider.insert(orcamentoFluxoCaixaModel);
      } else {
        return await orcamentoFluxoCaixaApiProvider.insert(orcamentoFluxoCaixaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await orcamentoFluxoCaixaDriftProvider.delete(id) ?? false;
    } else {
      return await orcamentoFluxoCaixaApiProvider.delete(id) ?? false;
    }
  }
}