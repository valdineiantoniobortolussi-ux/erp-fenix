import 'package:estoque/app/infra/constants.dart';
import 'package:estoque/app/data/provider/api/estoque_marca_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_marca_drift_provider.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueMarcaRepository {
  final EstoqueMarcaApiProvider estoqueMarcaApiProvider;
  final EstoqueMarcaDriftProvider estoqueMarcaDriftProvider;

  EstoqueMarcaRepository({required this.estoqueMarcaApiProvider, required this.estoqueMarcaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueMarcaDriftProvider.getList(filter: filter);
    } else {
      return await estoqueMarcaApiProvider.getList(filter: filter);
    }
  }

  Future<EstoqueMarcaModel?>? save({required EstoqueMarcaModel estoqueMarcaModel}) async {
    if (estoqueMarcaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await estoqueMarcaDriftProvider.update(estoqueMarcaModel);
      } else {
        return await estoqueMarcaApiProvider.update(estoqueMarcaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await estoqueMarcaDriftProvider.insert(estoqueMarcaModel);
      } else {
        return await estoqueMarcaApiProvider.insert(estoqueMarcaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueMarcaDriftProvider.delete(id) ?? false;
    } else {
      return await estoqueMarcaApiProvider.delete(id) ?? false;
    }
  }
}