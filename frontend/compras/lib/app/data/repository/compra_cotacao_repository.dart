import 'package:compras/app/infra/constants.dart';
import 'package:compras/app/data/provider/api/compra_cotacao_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_cotacao_drift_provider.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraCotacaoRepository {
  final CompraCotacaoApiProvider compraCotacaoApiProvider;
  final CompraCotacaoDriftProvider compraCotacaoDriftProvider;

  CompraCotacaoRepository({required this.compraCotacaoApiProvider, required this.compraCotacaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await compraCotacaoDriftProvider.getList(filter: filter);
    } else {
      return await compraCotacaoApiProvider.getList(filter: filter);
    }
  }

  Future<CompraCotacaoModel?>? save({required CompraCotacaoModel compraCotacaoModel}) async {
    if (compraCotacaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await compraCotacaoDriftProvider.update(compraCotacaoModel);
      } else {
        return await compraCotacaoApiProvider.update(compraCotacaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await compraCotacaoDriftProvider.insert(compraCotacaoModel);
      } else {
        return await compraCotacaoApiProvider.insert(compraCotacaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await compraCotacaoDriftProvider.delete(id) ?? false;
    } else {
      return await compraCotacaoApiProvider.delete(id) ?? false;
    }
  }
}