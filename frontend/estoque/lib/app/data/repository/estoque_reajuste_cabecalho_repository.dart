import 'package:estoque/app/infra/constants.dart';
import 'package:estoque/app/data/provider/api/estoque_reajuste_cabecalho_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_reajuste_cabecalho_drift_provider.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueReajusteCabecalhoRepository {
  final EstoqueReajusteCabecalhoApiProvider estoqueReajusteCabecalhoApiProvider;
  final EstoqueReajusteCabecalhoDriftProvider estoqueReajusteCabecalhoDriftProvider;

  EstoqueReajusteCabecalhoRepository({required this.estoqueReajusteCabecalhoApiProvider, required this.estoqueReajusteCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueReajusteCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await estoqueReajusteCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<EstoqueReajusteCabecalhoModel?>? save({required EstoqueReajusteCabecalhoModel estoqueReajusteCabecalhoModel}) async {
    if (estoqueReajusteCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await estoqueReajusteCabecalhoDriftProvider.update(estoqueReajusteCabecalhoModel);
      } else {
        return await estoqueReajusteCabecalhoApiProvider.update(estoqueReajusteCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await estoqueReajusteCabecalhoDriftProvider.insert(estoqueReajusteCabecalhoModel);
      } else {
        return await estoqueReajusteCabecalhoApiProvider.insert(estoqueReajusteCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueReajusteCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await estoqueReajusteCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}