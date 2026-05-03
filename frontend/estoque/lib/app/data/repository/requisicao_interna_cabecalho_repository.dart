import 'package:estoque/app/infra/constants.dart';
import 'package:estoque/app/data/provider/api/requisicao_interna_cabecalho_api_provider.dart';
import 'package:estoque/app/data/provider/drift/requisicao_interna_cabecalho_drift_provider.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class RequisicaoInternaCabecalhoRepository {
  final RequisicaoInternaCabecalhoApiProvider requisicaoInternaCabecalhoApiProvider;
  final RequisicaoInternaCabecalhoDriftProvider requisicaoInternaCabecalhoDriftProvider;

  RequisicaoInternaCabecalhoRepository({required this.requisicaoInternaCabecalhoApiProvider, required this.requisicaoInternaCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await requisicaoInternaCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await requisicaoInternaCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<RequisicaoInternaCabecalhoModel?>? save({required RequisicaoInternaCabecalhoModel requisicaoInternaCabecalhoModel}) async {
    if (requisicaoInternaCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await requisicaoInternaCabecalhoDriftProvider.update(requisicaoInternaCabecalhoModel);
      } else {
        return await requisicaoInternaCabecalhoApiProvider.update(requisicaoInternaCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await requisicaoInternaCabecalhoDriftProvider.insert(requisicaoInternaCabecalhoModel);
      } else {
        return await requisicaoInternaCabecalhoApiProvider.insert(requisicaoInternaCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await requisicaoInternaCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await requisicaoInternaCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}