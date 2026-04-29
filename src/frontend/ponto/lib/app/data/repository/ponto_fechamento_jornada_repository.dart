import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_fechamento_jornada_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_fechamento_jornada_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoFechamentoJornadaRepository {
  final PontoFechamentoJornadaApiProvider pontoFechamentoJornadaApiProvider;
  final PontoFechamentoJornadaDriftProvider pontoFechamentoJornadaDriftProvider;

  PontoFechamentoJornadaRepository({required this.pontoFechamentoJornadaApiProvider, required this.pontoFechamentoJornadaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoFechamentoJornadaDriftProvider.getList(filter: filter);
    } else {
      return await pontoFechamentoJornadaApiProvider.getList(filter: filter);
    }
  }

  Future<PontoFechamentoJornadaModel?>? save({required PontoFechamentoJornadaModel pontoFechamentoJornadaModel}) async {
    if (pontoFechamentoJornadaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoFechamentoJornadaDriftProvider.update(pontoFechamentoJornadaModel);
      } else {
        return await pontoFechamentoJornadaApiProvider.update(pontoFechamentoJornadaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoFechamentoJornadaDriftProvider.insert(pontoFechamentoJornadaModel);
      } else {
        return await pontoFechamentoJornadaApiProvider.insert(pontoFechamentoJornadaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoFechamentoJornadaDriftProvider.delete(id) ?? false;
    } else {
      return await pontoFechamentoJornadaApiProvider.delete(id) ?? false;
    }
  }
}