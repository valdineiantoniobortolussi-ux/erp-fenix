import 'package:compras/app/infra/constants.dart';
import 'package:compras/app/data/provider/api/compra_tipo_pedido_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_tipo_pedido_drift_provider.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraTipoPedidoRepository {
  final CompraTipoPedidoApiProvider compraTipoPedidoApiProvider;
  final CompraTipoPedidoDriftProvider compraTipoPedidoDriftProvider;

  CompraTipoPedidoRepository({required this.compraTipoPedidoApiProvider, required this.compraTipoPedidoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await compraTipoPedidoDriftProvider.getList(filter: filter);
    } else {
      return await compraTipoPedidoApiProvider.getList(filter: filter);
    }
  }

  Future<CompraTipoPedidoModel?>? save({required CompraTipoPedidoModel compraTipoPedidoModel}) async {
    if (compraTipoPedidoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await compraTipoPedidoDriftProvider.update(compraTipoPedidoModel);
      } else {
        return await compraTipoPedidoApiProvider.update(compraTipoPedidoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await compraTipoPedidoDriftProvider.insert(compraTipoPedidoModel);
      } else {
        return await compraTipoPedidoApiProvider.insert(compraTipoPedidoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await compraTipoPedidoDriftProvider.delete(id) ?? false;
    } else {
      return await compraTipoPedidoApiProvider.delete(id) ?? false;
    }
  }
}