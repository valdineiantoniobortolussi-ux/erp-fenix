import 'package:esocial/app/infra/constants.dart';
import 'package:esocial/app/data/provider/api/esocial_natureza_juridica_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_natureza_juridica_drift_provider.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialNaturezaJuridicaRepository {
  final EsocialNaturezaJuridicaApiProvider esocialNaturezaJuridicaApiProvider;
  final EsocialNaturezaJuridicaDriftProvider esocialNaturezaJuridicaDriftProvider;

  EsocialNaturezaJuridicaRepository({required this.esocialNaturezaJuridicaApiProvider, required this.esocialNaturezaJuridicaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialNaturezaJuridicaDriftProvider.getList(filter: filter);
    } else {
      return await esocialNaturezaJuridicaApiProvider.getList(filter: filter);
    }
  }

  Future<EsocialNaturezaJuridicaModel?>? save({required EsocialNaturezaJuridicaModel esocialNaturezaJuridicaModel}) async {
    if (esocialNaturezaJuridicaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await esocialNaturezaJuridicaDriftProvider.update(esocialNaturezaJuridicaModel);
      } else {
        return await esocialNaturezaJuridicaApiProvider.update(esocialNaturezaJuridicaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await esocialNaturezaJuridicaDriftProvider.insert(esocialNaturezaJuridicaModel);
      } else {
        return await esocialNaturezaJuridicaApiProvider.insert(esocialNaturezaJuridicaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialNaturezaJuridicaDriftProvider.delete(id) ?? false;
    } else {
      return await esocialNaturezaJuridicaApiProvider.delete(id) ?? false;
    }
  }
}