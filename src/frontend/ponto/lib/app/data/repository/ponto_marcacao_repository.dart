import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_marcacao_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_marcacao_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoMarcacaoRepository {
  final PontoMarcacaoApiProvider pontoMarcacaoApiProvider;
  final PontoMarcacaoDriftProvider pontoMarcacaoDriftProvider;

  PontoMarcacaoRepository({required this.pontoMarcacaoApiProvider, required this.pontoMarcacaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoMarcacaoDriftProvider.getList(filter: filter);
    } else {
      return await pontoMarcacaoApiProvider.getList(filter: filter);
    }
  }

  Future<PontoMarcacaoModel?>? save({required PontoMarcacaoModel pontoMarcacaoModel}) async {
    if (pontoMarcacaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoMarcacaoDriftProvider.update(pontoMarcacaoModel);
      } else {
        return await pontoMarcacaoApiProvider.update(pontoMarcacaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoMarcacaoDriftProvider.insert(pontoMarcacaoModel);
      } else {
        return await pontoMarcacaoApiProvider.insert(pontoMarcacaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoMarcacaoDriftProvider.delete(id) ?? false;
    } else {
      return await pontoMarcacaoApiProvider.delete(id) ?? false;
    }
  }
}