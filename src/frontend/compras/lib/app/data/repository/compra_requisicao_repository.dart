import 'package:compras/app/infra/constants.dart';
import 'package:compras/app/data/provider/api/compra_requisicao_api_provider.dart';
import 'package:compras/app/data/provider/drift/compra_requisicao_drift_provider.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraRequisicaoRepository {
  final CompraRequisicaoApiProvider compraRequisicaoApiProvider;
  final CompraRequisicaoDriftProvider compraRequisicaoDriftProvider;

  CompraRequisicaoRepository({required this.compraRequisicaoApiProvider, required this.compraRequisicaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await compraRequisicaoDriftProvider.getList(filter: filter);
    } else {
      return await compraRequisicaoApiProvider.getList(filter: filter);
    }
  }

  Future<CompraRequisicaoModel?>? save({required CompraRequisicaoModel compraRequisicaoModel}) async {
    if (compraRequisicaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await compraRequisicaoDriftProvider.update(compraRequisicaoModel);
      } else {
        return await compraRequisicaoApiProvider.update(compraRequisicaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await compraRequisicaoDriftProvider.insert(compraRequisicaoModel);
      } else {
        return await compraRequisicaoApiProvider.insert(compraRequisicaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await compraRequisicaoDriftProvider.delete(id) ?? false;
    } else {
      return await compraRequisicaoApiProvider.delete(id) ?? false;
    }
  }
}