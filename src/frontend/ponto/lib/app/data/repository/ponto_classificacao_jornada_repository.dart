import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_classificacao_jornada_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_classificacao_jornada_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoClassificacaoJornadaRepository {
  final PontoClassificacaoJornadaApiProvider pontoClassificacaoJornadaApiProvider;
  final PontoClassificacaoJornadaDriftProvider pontoClassificacaoJornadaDriftProvider;

  PontoClassificacaoJornadaRepository({required this.pontoClassificacaoJornadaApiProvider, required this.pontoClassificacaoJornadaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoClassificacaoJornadaDriftProvider.getList(filter: filter);
    } else {
      return await pontoClassificacaoJornadaApiProvider.getList(filter: filter);
    }
  }

  Future<PontoClassificacaoJornadaModel?>? save({required PontoClassificacaoJornadaModel pontoClassificacaoJornadaModel}) async {
    if (pontoClassificacaoJornadaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoClassificacaoJornadaDriftProvider.update(pontoClassificacaoJornadaModel);
      } else {
        return await pontoClassificacaoJornadaApiProvider.update(pontoClassificacaoJornadaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoClassificacaoJornadaDriftProvider.insert(pontoClassificacaoJornadaModel);
      } else {
        return await pontoClassificacaoJornadaApiProvider.insert(pontoClassificacaoJornadaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoClassificacaoJornadaDriftProvider.delete(id) ?? false;
    } else {
      return await pontoClassificacaoJornadaApiProvider.delete(id) ?? false;
    }
  }
}