import 'package:esocial/app/infra/constants.dart';
import 'package:esocial/app/data/provider/api/esocial_rubrica_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_rubrica_drift_provider.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialRubricaRepository {
  final EsocialRubricaApiProvider esocialRubricaApiProvider;
  final EsocialRubricaDriftProvider esocialRubricaDriftProvider;

  EsocialRubricaRepository({required this.esocialRubricaApiProvider, required this.esocialRubricaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialRubricaDriftProvider.getList(filter: filter);
    } else {
      return await esocialRubricaApiProvider.getList(filter: filter);
    }
  }

  Future<EsocialRubricaModel?>? save({required EsocialRubricaModel esocialRubricaModel}) async {
    if (esocialRubricaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await esocialRubricaDriftProvider.update(esocialRubricaModel);
      } else {
        return await esocialRubricaApiProvider.update(esocialRubricaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await esocialRubricaDriftProvider.insert(esocialRubricaModel);
      } else {
        return await esocialRubricaApiProvider.insert(esocialRubricaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialRubricaDriftProvider.delete(id) ?? false;
    } else {
      return await esocialRubricaApiProvider.delete(id) ?? false;
    }
  }
}