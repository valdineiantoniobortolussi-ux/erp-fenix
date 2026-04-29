import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/cep_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cep_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CepRepository {
  final CepApiProvider cepApiProvider;
  final CepDriftProvider cepDriftProvider;

  CepRepository({required this.cepApiProvider, required this.cepDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cepDriftProvider.getList(filter: filter);
    } else {
      return await cepApiProvider.getList(filter: filter);
    }
  }

  Future<CepModel?>? save({required CepModel cepModel}) async {
    if (cepModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cepDriftProvider.update(cepModel);
      } else {
        return await cepApiProvider.update(cepModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cepDriftProvider.insert(cepModel);
      } else {
        return await cepApiProvider.insert(cepModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cepDriftProvider.delete(id) ?? false;
    } else {
      return await cepApiProvider.delete(id) ?? false;
    }
  }
}