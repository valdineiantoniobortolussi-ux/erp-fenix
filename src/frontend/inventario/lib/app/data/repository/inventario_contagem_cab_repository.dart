import 'package:inventario/app/infra/constants.dart';
import 'package:inventario/app/data/provider/api/inventario_contagem_cab_api_provider.dart';
import 'package:inventario/app/data/provider/drift/inventario_contagem_cab_drift_provider.dart';
import 'package:inventario/app/data/model/model_imports.dart';

class InventarioContagemCabRepository {
  final InventarioContagemCabApiProvider inventarioContagemCabApiProvider;
  final InventarioContagemCabDriftProvider inventarioContagemCabDriftProvider;

  InventarioContagemCabRepository({required this.inventarioContagemCabApiProvider, required this.inventarioContagemCabDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await inventarioContagemCabDriftProvider.getList(filter: filter);
    } else {
      return await inventarioContagemCabApiProvider.getList(filter: filter);
    }
  }

  Future<InventarioContagemCabModel?>? save({required InventarioContagemCabModel inventarioContagemCabModel}) async {
    if (inventarioContagemCabModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await inventarioContagemCabDriftProvider.update(inventarioContagemCabModel);
      } else {
        return await inventarioContagemCabApiProvider.update(inventarioContagemCabModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await inventarioContagemCabDriftProvider.insert(inventarioContagemCabModel);
      } else {
        return await inventarioContagemCabApiProvider.insert(inventarioContagemCabModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await inventarioContagemCabDriftProvider.delete(id) ?? false;
    } else {
      return await inventarioContagemCabApiProvider.delete(id) ?? false;
    }
  }
}