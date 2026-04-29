import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_dre_cabecalho_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_dre_cabecalho_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilDreCabecalhoRepository {
  final ContabilDreCabecalhoApiProvider contabilDreCabecalhoApiProvider;
  final ContabilDreCabecalhoDriftProvider contabilDreCabecalhoDriftProvider;

  ContabilDreCabecalhoRepository({required this.contabilDreCabecalhoApiProvider, required this.contabilDreCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilDreCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await contabilDreCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilDreCabecalhoModel?>? save({required ContabilDreCabecalhoModel contabilDreCabecalhoModel}) async {
    if (contabilDreCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilDreCabecalhoDriftProvider.update(contabilDreCabecalhoModel);
      } else {
        return await contabilDreCabecalhoApiProvider.update(contabilDreCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilDreCabecalhoDriftProvider.insert(contabilDreCabecalhoModel);
      } else {
        return await contabilDreCabecalhoApiProvider.insert(contabilDreCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilDreCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await contabilDreCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}