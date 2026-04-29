import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/patrim_indice_atualizacao_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_indice_atualizacao_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimIndiceAtualizacaoRepository {
  final PatrimIndiceAtualizacaoApiProvider patrimIndiceAtualizacaoApiProvider;
  final PatrimIndiceAtualizacaoDriftProvider patrimIndiceAtualizacaoDriftProvider;

  PatrimIndiceAtualizacaoRepository({required this.patrimIndiceAtualizacaoApiProvider, required this.patrimIndiceAtualizacaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimIndiceAtualizacaoDriftProvider.getList(filter: filter);
    } else {
      return await patrimIndiceAtualizacaoApiProvider.getList(filter: filter);
    }
  }

  Future<PatrimIndiceAtualizacaoModel?>? save({required PatrimIndiceAtualizacaoModel patrimIndiceAtualizacaoModel}) async {
    if (patrimIndiceAtualizacaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await patrimIndiceAtualizacaoDriftProvider.update(patrimIndiceAtualizacaoModel);
      } else {
        return await patrimIndiceAtualizacaoApiProvider.update(patrimIndiceAtualizacaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await patrimIndiceAtualizacaoDriftProvider.insert(patrimIndiceAtualizacaoModel);
      } else {
        return await patrimIndiceAtualizacaoApiProvider.insert(patrimIndiceAtualizacaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimIndiceAtualizacaoDriftProvider.delete(id) ?? false;
    } else {
      return await patrimIndiceAtualizacaoApiProvider.delete(id) ?? false;
    }
  }
}