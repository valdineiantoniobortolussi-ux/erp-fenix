import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_tipo_afastamento_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_tipo_afastamento_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaTipoAfastamentoRepository {
  final FolhaTipoAfastamentoApiProvider folhaTipoAfastamentoApiProvider;
  final FolhaTipoAfastamentoDriftProvider folhaTipoAfastamentoDriftProvider;

  FolhaTipoAfastamentoRepository({required this.folhaTipoAfastamentoApiProvider, required this.folhaTipoAfastamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaTipoAfastamentoDriftProvider.getList(filter: filter);
    } else {
      return await folhaTipoAfastamentoApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaTipoAfastamentoModel?>? save({required FolhaTipoAfastamentoModel folhaTipoAfastamentoModel}) async {
    if (folhaTipoAfastamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaTipoAfastamentoDriftProvider.update(folhaTipoAfastamentoModel);
      } else {
        return await folhaTipoAfastamentoApiProvider.update(folhaTipoAfastamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaTipoAfastamentoDriftProvider.insert(folhaTipoAfastamentoModel);
      } else {
        return await folhaTipoAfastamentoApiProvider.insert(folhaTipoAfastamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaTipoAfastamentoDriftProvider.delete(id) ?? false;
    } else {
      return await folhaTipoAfastamentoApiProvider.delete(id) ?? false;
    }
  }
}