import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/patrim_tipo_aquisicao_bem_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_tipo_aquisicao_bem_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimTipoAquisicaoBemRepository {
  final PatrimTipoAquisicaoBemApiProvider patrimTipoAquisicaoBemApiProvider;
  final PatrimTipoAquisicaoBemDriftProvider patrimTipoAquisicaoBemDriftProvider;

  PatrimTipoAquisicaoBemRepository({required this.patrimTipoAquisicaoBemApiProvider, required this.patrimTipoAquisicaoBemDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimTipoAquisicaoBemDriftProvider.getList(filter: filter);
    } else {
      return await patrimTipoAquisicaoBemApiProvider.getList(filter: filter);
    }
  }

  Future<PatrimTipoAquisicaoBemModel?>? save({required PatrimTipoAquisicaoBemModel patrimTipoAquisicaoBemModel}) async {
    if (patrimTipoAquisicaoBemModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await patrimTipoAquisicaoBemDriftProvider.update(patrimTipoAquisicaoBemModel);
      } else {
        return await patrimTipoAquisicaoBemApiProvider.update(patrimTipoAquisicaoBemModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await patrimTipoAquisicaoBemDriftProvider.insert(patrimTipoAquisicaoBemModel);
      } else {
        return await patrimTipoAquisicaoBemApiProvider.insert(patrimTipoAquisicaoBemModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimTipoAquisicaoBemDriftProvider.delete(id) ?? false;
    } else {
      return await patrimTipoAquisicaoBemApiProvider.delete(id) ?? false;
    }
  }
}