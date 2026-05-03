import 'package:orcamentos/app/infra/constants.dart';
import 'package:orcamentos/app/data/provider/api/orcamento_empresarial_api_provider.dart';
import 'package:orcamentos/app/data/provider/drift/orcamento_empresarial_drift_provider.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoEmpresarialRepository {
  final OrcamentoEmpresarialApiProvider orcamentoEmpresarialApiProvider;
  final OrcamentoEmpresarialDriftProvider orcamentoEmpresarialDriftProvider;

  OrcamentoEmpresarialRepository({required this.orcamentoEmpresarialApiProvider, required this.orcamentoEmpresarialDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await orcamentoEmpresarialDriftProvider.getList(filter: filter);
    } else {
      return await orcamentoEmpresarialApiProvider.getList(filter: filter);
    }
  }

  Future<OrcamentoEmpresarialModel?>? save({required OrcamentoEmpresarialModel orcamentoEmpresarialModel}) async {
    if (orcamentoEmpresarialModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await orcamentoEmpresarialDriftProvider.update(orcamentoEmpresarialModel);
      } else {
        return await orcamentoEmpresarialApiProvider.update(orcamentoEmpresarialModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await orcamentoEmpresarialDriftProvider.insert(orcamentoEmpresarialModel);
      } else {
        return await orcamentoEmpresarialApiProvider.insert(orcamentoEmpresarialModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await orcamentoEmpresarialDriftProvider.delete(id) ?? false;
    } else {
      return await orcamentoEmpresarialApiProvider.delete(id) ?? false;
    }
  }
}