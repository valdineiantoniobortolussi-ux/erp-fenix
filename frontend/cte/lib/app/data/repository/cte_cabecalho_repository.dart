import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_cabecalho_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_cabecalho_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteCabecalhoRepository {
  final CteCabecalhoApiProvider cteCabecalhoApiProvider;
  final CteCabecalhoDriftProvider cteCabecalhoDriftProvider;

  CteCabecalhoRepository({required this.cteCabecalhoApiProvider, required this.cteCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await cteCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<CteCabecalhoModel?>? save({required CteCabecalhoModel cteCabecalhoModel}) async {
    if (cteCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteCabecalhoDriftProvider.update(cteCabecalhoModel);
      } else {
        return await cteCabecalhoApiProvider.update(cteCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteCabecalhoDriftProvider.insert(cteCabecalhoModel);
      } else {
        return await cteCabecalhoApiProvider.insert(cteCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await cteCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}