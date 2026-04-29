import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/nivel_formacao_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/nivel_formacao_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class NivelFormacaoRepository {
  final NivelFormacaoApiProvider nivelFormacaoApiProvider;
  final NivelFormacaoDriftProvider nivelFormacaoDriftProvider;

  NivelFormacaoRepository({required this.nivelFormacaoApiProvider, required this.nivelFormacaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nivelFormacaoDriftProvider.getList(filter: filter);
    } else {
      return await nivelFormacaoApiProvider.getList(filter: filter);
    }
  }

  Future<NivelFormacaoModel?>? save({required NivelFormacaoModel nivelFormacaoModel}) async {
    if (nivelFormacaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nivelFormacaoDriftProvider.update(nivelFormacaoModel);
      } else {
        return await nivelFormacaoApiProvider.update(nivelFormacaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nivelFormacaoDriftProvider.insert(nivelFormacaoModel);
      } else {
        return await nivelFormacaoApiProvider.insert(nivelFormacaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nivelFormacaoDriftProvider.delete(id) ?? false;
    } else {
      return await nivelFormacaoApiProvider.delete(id) ?? false;
    }
  }
}