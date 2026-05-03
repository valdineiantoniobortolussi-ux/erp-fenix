import 'package:contratos/app/infra/constants.dart';
import 'package:contratos/app/data/provider/api/contrato_api_provider.dart';
import 'package:contratos/app/data/provider/drift/contrato_drift_provider.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoRepository {
  final ContratoApiProvider contratoApiProvider;
  final ContratoDriftProvider contratoDriftProvider;

  ContratoRepository({required this.contratoApiProvider, required this.contratoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contratoDriftProvider.getList(filter: filter);
    } else {
      return await contratoApiProvider.getList(filter: filter);
    }
  }

  Future<ContratoModel?>? save({required ContratoModel contratoModel}) async {
    if (contratoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contratoDriftProvider.update(contratoModel);
      } else {
        return await contratoApiProvider.update(contratoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contratoDriftProvider.insert(contratoModel);
      } else {
        return await contratoApiProvider.insert(contratoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contratoDriftProvider.delete(id) ?? false;
    } else {
      return await contratoApiProvider.delete(id) ?? false;
    }
  }
}