import 'package:estoque/app/infra/constants.dart';
import 'package:estoque/app/data/provider/api/estoque_cor_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_cor_drift_provider.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueCorRepository {
  final EstoqueCorApiProvider estoqueCorApiProvider;
  final EstoqueCorDriftProvider estoqueCorDriftProvider;

  EstoqueCorRepository({required this.estoqueCorApiProvider, required this.estoqueCorDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueCorDriftProvider.getList(filter: filter);
    } else {
      return await estoqueCorApiProvider.getList(filter: filter);
    }
  }

  Future<EstoqueCorModel?>? save({required EstoqueCorModel estoqueCorModel}) async {
    if (estoqueCorModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await estoqueCorDriftProvider.update(estoqueCorModel);
      } else {
        return await estoqueCorApiProvider.update(estoqueCorModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await estoqueCorDriftProvider.insert(estoqueCorModel);
      } else {
        return await estoqueCorApiProvider.insert(estoqueCorModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueCorDriftProvider.delete(id) ?? false;
    } else {
      return await estoqueCorApiProvider.delete(id) ?? false;
    }
  }
}