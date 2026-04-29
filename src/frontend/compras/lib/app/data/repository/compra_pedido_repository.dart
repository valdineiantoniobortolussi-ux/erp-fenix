import 'package:compras/app/infra/constants.dart';
import 'package:compras/app/data/provider/api/compra_pedido_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_pedido_drift_provider.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraPedidoRepository {
  final CompraPedidoApiProvider compraPedidoApiProvider;
  final CompraPedidoDriftProvider compraPedidoDriftProvider;

  CompraPedidoRepository({required this.compraPedidoApiProvider, required this.compraPedidoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await compraPedidoDriftProvider.getList(filter: filter);
    } else {
      return await compraPedidoApiProvider.getList(filter: filter);
    }
  }

  Future<CompraPedidoModel?>? save({required CompraPedidoModel compraPedidoModel}) async {
    if (compraPedidoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await compraPedidoDriftProvider.update(compraPedidoModel);
      } else {
        return await compraPedidoApiProvider.update(compraPedidoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await compraPedidoDriftProvider.insert(compraPedidoModel);
      } else {
        return await compraPedidoApiProvider.insert(compraPedidoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await compraPedidoDriftProvider.delete(id) ?? false;
    } else {
      return await compraPedidoApiProvider.delete(id) ?? false;
    }
  }
}