import 'package:contratos/app/infra/constants.dart';
import 'package:contratos/app/data/provider/api/tipo_contrato_api_provider.dart';
import 'package:contratos/app/data/provider/drift/tipo_contrato_drift_provider.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class TipoContratoRepository {
  final TipoContratoApiProvider tipoContratoApiProvider;
  final TipoContratoDriftProvider tipoContratoDriftProvider;

  TipoContratoRepository({required this.tipoContratoApiProvider, required this.tipoContratoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tipoContratoDriftProvider.getList(filter: filter);
    } else {
      return await tipoContratoApiProvider.getList(filter: filter);
    }
  }

  Future<TipoContratoModel?>? save({required TipoContratoModel tipoContratoModel}) async {
    if (tipoContratoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tipoContratoDriftProvider.update(tipoContratoModel);
      } else {
        return await tipoContratoApiProvider.update(tipoContratoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tipoContratoDriftProvider.insert(tipoContratoModel);
      } else {
        return await tipoContratoApiProvider.insert(tipoContratoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tipoContratoDriftProvider.delete(id) ?? false;
    } else {
      return await tipoContratoApiProvider.delete(id) ?? false;
    }
  }
}