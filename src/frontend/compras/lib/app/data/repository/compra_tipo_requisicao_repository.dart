import 'package:compras/app/infra/constants.dart';
import 'package:compras/app/data/provider/api/compra_tipo_requisicao_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_tipo_requisicao_drift_provider.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraTipoRequisicaoRepository {
  final CompraTipoRequisicaoApiProvider compraTipoRequisicaoApiProvider;
  final CompraTipoRequisicaoDriftProvider compraTipoRequisicaoDriftProvider;

  CompraTipoRequisicaoRepository({required this.compraTipoRequisicaoApiProvider, required this.compraTipoRequisicaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await compraTipoRequisicaoDriftProvider.getList(filter: filter);
    } else {
      return await compraTipoRequisicaoApiProvider.getList(filter: filter);
    }
  }

  Future<CompraTipoRequisicaoModel?>? save({required CompraTipoRequisicaoModel compraTipoRequisicaoModel}) async {
    if (compraTipoRequisicaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await compraTipoRequisicaoDriftProvider.update(compraTipoRequisicaoModel);
      } else {
        return await compraTipoRequisicaoApiProvider.update(compraTipoRequisicaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await compraTipoRequisicaoDriftProvider.insert(compraTipoRequisicaoModel);
      } else {
        return await compraTipoRequisicaoApiProvider.insert(compraTipoRequisicaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await compraTipoRequisicaoDriftProvider.delete(id) ?? false;
    } else {
      return await compraTipoRequisicaoApiProvider.delete(id) ?? false;
    }
  }
}