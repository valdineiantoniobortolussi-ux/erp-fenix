import 'package:estoque/app/infra/constants.dart';
import 'package:estoque/app/data/provider/api/estoque_sabor_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_sabor_drift_provider.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueSaborRepository {
  final EstoqueSaborApiProvider estoqueSaborApiProvider;
  final EstoqueSaborDriftProvider estoqueSaborDriftProvider;

  EstoqueSaborRepository({required this.estoqueSaborApiProvider, required this.estoqueSaborDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueSaborDriftProvider.getList(filter: filter);
    } else {
      return await estoqueSaborApiProvider.getList(filter: filter);
    }
  }

  Future<EstoqueSaborModel?>? save({required EstoqueSaborModel estoqueSaborModel}) async {
    if (estoqueSaborModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await estoqueSaborDriftProvider.update(estoqueSaborModel);
      } else {
        return await estoqueSaborApiProvider.update(estoqueSaborModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await estoqueSaborDriftProvider.insert(estoqueSaborModel);
      } else {
        return await estoqueSaborApiProvider.insert(estoqueSaborModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueSaborDriftProvider.delete(id) ?? false;
    } else {
      return await estoqueSaborApiProvider.delete(id) ?? false;
    }
  }
}