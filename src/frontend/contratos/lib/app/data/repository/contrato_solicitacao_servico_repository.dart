import 'package:contratos/app/infra/constants.dart';
import 'package:contratos/app/data/provider/api/contrato_solicitacao_servico_api_provider.dart';
import 'package:contratos/app/data/provider/drift/contrato_solicitacao_servico_drift_provider.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoSolicitacaoServicoRepository {
  final ContratoSolicitacaoServicoApiProvider contratoSolicitacaoServicoApiProvider;
  final ContratoSolicitacaoServicoDriftProvider contratoSolicitacaoServicoDriftProvider;

  ContratoSolicitacaoServicoRepository({required this.contratoSolicitacaoServicoApiProvider, required this.contratoSolicitacaoServicoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contratoSolicitacaoServicoDriftProvider.getList(filter: filter);
    } else {
      return await contratoSolicitacaoServicoApiProvider.getList(filter: filter);
    }
  }

  Future<ContratoSolicitacaoServicoModel?>? save({required ContratoSolicitacaoServicoModel contratoSolicitacaoServicoModel}) async {
    if (contratoSolicitacaoServicoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contratoSolicitacaoServicoDriftProvider.update(contratoSolicitacaoServicoModel);
      } else {
        return await contratoSolicitacaoServicoApiProvider.update(contratoSolicitacaoServicoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contratoSolicitacaoServicoDriftProvider.insert(contratoSolicitacaoServicoModel);
      } else {
        return await contratoSolicitacaoServicoApiProvider.insert(contratoSolicitacaoServicoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contratoSolicitacaoServicoDriftProvider.delete(id) ?? false;
    } else {
      return await contratoSolicitacaoServicoApiProvider.delete(id) ?? false;
    }
  }
}