import 'package:inventario/app/infra/constants.dart';
import 'package:inventario/app/data/provider/api/inventario_ajuste_cab_api_provider.dart';
import 'package:inventario/app/data/provider/drift/inventario_ajuste_cab_drift_provider.dart';
import 'package:inventario/app/data/model/model_imports.dart';

class InventarioAjusteCabRepository {
  final InventarioAjusteCabApiProvider inventarioAjusteCabApiProvider;
  final InventarioAjusteCabDriftProvider inventarioAjusteCabDriftProvider;

  InventarioAjusteCabRepository({required this.inventarioAjusteCabApiProvider, required this.inventarioAjusteCabDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await inventarioAjusteCabDriftProvider.getList(filter: filter);
    } else {
      return await inventarioAjusteCabApiProvider.getList(filter: filter);
    }
  }

  Future<InventarioAjusteCabModel?>? save({required InventarioAjusteCabModel inventarioAjusteCabModel}) async {
    if (inventarioAjusteCabModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await inventarioAjusteCabDriftProvider.update(inventarioAjusteCabModel);
      } else {
        return await inventarioAjusteCabApiProvider.update(inventarioAjusteCabModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await inventarioAjusteCabDriftProvider.insert(inventarioAjusteCabModel);
      } else {
        return await inventarioAjusteCabApiProvider.insert(inventarioAjusteCabModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await inventarioAjusteCabDriftProvider.delete(id) ?? false;
    } else {
      return await inventarioAjusteCabApiProvider.delete(id) ?? false;
    }
  }
}