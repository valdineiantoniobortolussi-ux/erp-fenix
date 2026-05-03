import 'package:esocial/app/infra/constants.dart';
import 'package:esocial/app/data/provider/api/esocial_tipo_afastamento_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_tipo_afastamento_drift_provider.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialTipoAfastamentoRepository {
  final EsocialTipoAfastamentoApiProvider esocialTipoAfastamentoApiProvider;
  final EsocialTipoAfastamentoDriftProvider esocialTipoAfastamentoDriftProvider;

  EsocialTipoAfastamentoRepository({required this.esocialTipoAfastamentoApiProvider, required this.esocialTipoAfastamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialTipoAfastamentoDriftProvider.getList(filter: filter);
    } else {
      return await esocialTipoAfastamentoApiProvider.getList(filter: filter);
    }
  }

  Future<EsocialTipoAfastamentoModel?>? save({required EsocialTipoAfastamentoModel esocialTipoAfastamentoModel}) async {
    if (esocialTipoAfastamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await esocialTipoAfastamentoDriftProvider.update(esocialTipoAfastamentoModel);
      } else {
        return await esocialTipoAfastamentoApiProvider.update(esocialTipoAfastamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await esocialTipoAfastamentoDriftProvider.insert(esocialTipoAfastamentoModel);
      } else {
        return await esocialTipoAfastamentoApiProvider.insert(esocialTipoAfastamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialTipoAfastamentoDriftProvider.delete(id) ?? false;
    } else {
      return await esocialTipoAfastamentoApiProvider.delete(id) ?? false;
    }
  }
}