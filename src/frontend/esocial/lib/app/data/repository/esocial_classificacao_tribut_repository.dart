import 'package:esocial/app/infra/constants.dart';
import 'package:esocial/app/data/provider/api/esocial_classificacao_tribut_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_classificacao_tribut_drift_provider.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialClassificacaoTributRepository {
  final EsocialClassificacaoTributApiProvider esocialClassificacaoTributApiProvider;
  final EsocialClassificacaoTributDriftProvider esocialClassificacaoTributDriftProvider;

  EsocialClassificacaoTributRepository({required this.esocialClassificacaoTributApiProvider, required this.esocialClassificacaoTributDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialClassificacaoTributDriftProvider.getList(filter: filter);
    } else {
      return await esocialClassificacaoTributApiProvider.getList(filter: filter);
    }
  }

  Future<EsocialClassificacaoTributModel?>? save({required EsocialClassificacaoTributModel esocialClassificacaoTributModel}) async {
    if (esocialClassificacaoTributModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await esocialClassificacaoTributDriftProvider.update(esocialClassificacaoTributModel);
      } else {
        return await esocialClassificacaoTributApiProvider.update(esocialClassificacaoTributModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await esocialClassificacaoTributDriftProvider.insert(esocialClassificacaoTributModel);
      } else {
        return await esocialClassificacaoTributApiProvider.insert(esocialClassificacaoTributModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialClassificacaoTributDriftProvider.delete(id) ?? false;
    } else {
      return await esocialClassificacaoTributApiProvider.delete(id) ?? false;
    }
  }
}