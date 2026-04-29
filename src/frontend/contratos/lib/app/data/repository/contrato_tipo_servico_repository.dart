import 'package:contratos/app/infra/constants.dart';
import 'package:contratos/app/data/provider/api/contrato_tipo_servico_api_provider.dart';
import 'package:contratos/app/data/provider/drift/contrato_tipo_servico_drift_provider.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoTipoServicoRepository {
  final ContratoTipoServicoApiProvider contratoTipoServicoApiProvider;
  final ContratoTipoServicoDriftProvider contratoTipoServicoDriftProvider;

  ContratoTipoServicoRepository({required this.contratoTipoServicoApiProvider, required this.contratoTipoServicoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contratoTipoServicoDriftProvider.getList(filter: filter);
    } else {
      return await contratoTipoServicoApiProvider.getList(filter: filter);
    }
  }

  Future<ContratoTipoServicoModel?>? save({required ContratoTipoServicoModel contratoTipoServicoModel}) async {
    if (contratoTipoServicoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contratoTipoServicoDriftProvider.update(contratoTipoServicoModel);
      } else {
        return await contratoTipoServicoApiProvider.update(contratoTipoServicoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contratoTipoServicoDriftProvider.insert(contratoTipoServicoModel);
      } else {
        return await contratoTipoServicoApiProvider.insert(contratoTipoServicoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contratoTipoServicoDriftProvider.delete(id) ?? false;
    } else {
      return await contratoTipoServicoApiProvider.delete(id) ?? false;
    }
  }
}