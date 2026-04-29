import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_afastamento_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_afastamento_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaAfastamentoRepository {
  final FolhaAfastamentoApiProvider folhaAfastamentoApiProvider;
  final FolhaAfastamentoDriftProvider folhaAfastamentoDriftProvider;

  FolhaAfastamentoRepository({required this.folhaAfastamentoApiProvider, required this.folhaAfastamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaAfastamentoDriftProvider.getList(filter: filter);
    } else {
      return await folhaAfastamentoApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaAfastamentoModel?>? save({required FolhaAfastamentoModel folhaAfastamentoModel}) async {
    if (folhaAfastamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaAfastamentoDriftProvider.update(folhaAfastamentoModel);
      } else {
        return await folhaAfastamentoApiProvider.update(folhaAfastamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaAfastamentoDriftProvider.insert(folhaAfastamentoModel);
      } else {
        return await folhaAfastamentoApiProvider.insert(folhaAfastamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaAfastamentoDriftProvider.delete(id) ?? false;
    } else {
      return await folhaAfastamentoApiProvider.delete(id) ?? false;
    }
  }
}