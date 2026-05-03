import 'package:administrativo/app/infra/constants.dart';
import 'package:administrativo/app/data/provider/api/empresa_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/empresa_drift_provider.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class EmpresaRepository {
  final EmpresaApiProvider empresaApiProvider;
  final EmpresaDriftProvider empresaDriftProvider;

  EmpresaRepository({required this.empresaApiProvider, required this.empresaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await empresaDriftProvider.getList(filter: filter);
    } else {
      return await empresaApiProvider.getList(filter: filter);
    }
  }

  Future<EmpresaModel?>? save({required EmpresaModel empresaModel}) async {
    if (empresaModel.id != null) {
      if (Constants.usingLocalDatabase) {
        return await empresaDriftProvider.update(empresaModel);
      } else {
        return await empresaApiProvider.update(empresaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await empresaDriftProvider.insert(empresaModel);
      } else {
        return await empresaApiProvider.insert(empresaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await empresaDriftProvider.delete(id) ?? false;
    } else {
      return await empresaApiProvider.delete(id) ?? false;
    }
  }
}