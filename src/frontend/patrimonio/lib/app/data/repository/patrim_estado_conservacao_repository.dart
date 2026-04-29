import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/patrim_estado_conservacao_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_estado_conservacao_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimEstadoConservacaoRepository {
  final PatrimEstadoConservacaoApiProvider patrimEstadoConservacaoApiProvider;
  final PatrimEstadoConservacaoDriftProvider patrimEstadoConservacaoDriftProvider;

  PatrimEstadoConservacaoRepository({required this.patrimEstadoConservacaoApiProvider, required this.patrimEstadoConservacaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimEstadoConservacaoDriftProvider.getList(filter: filter);
    } else {
      return await patrimEstadoConservacaoApiProvider.getList(filter: filter);
    }
  }

  Future<PatrimEstadoConservacaoModel?>? save({required PatrimEstadoConservacaoModel patrimEstadoConservacaoModel}) async {
    if (patrimEstadoConservacaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await patrimEstadoConservacaoDriftProvider.update(patrimEstadoConservacaoModel);
      } else {
        return await patrimEstadoConservacaoApiProvider.update(patrimEstadoConservacaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await patrimEstadoConservacaoDriftProvider.insert(patrimEstadoConservacaoModel);
      } else {
        return await patrimEstadoConservacaoApiProvider.insert(patrimEstadoConservacaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimEstadoConservacaoDriftProvider.delete(id) ?? false;
    } else {
      return await patrimEstadoConservacaoApiProvider.delete(id) ?? false;
    }
  }
}