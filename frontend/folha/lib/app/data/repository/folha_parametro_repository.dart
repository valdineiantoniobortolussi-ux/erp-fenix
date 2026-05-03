import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_parametro_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_parametro_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaParametroRepository {
  final FolhaParametroApiProvider folhaParametroApiProvider;
  final FolhaParametroDriftProvider folhaParametroDriftProvider;

  FolhaParametroRepository({required this.folhaParametroApiProvider, required this.folhaParametroDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaParametroDriftProvider.getList(filter: filter);
    } else {
      return await folhaParametroApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaParametroModel?>? save({required FolhaParametroModel folhaParametroModel}) async {
    if (folhaParametroModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaParametroDriftProvider.update(folhaParametroModel);
      } else {
        return await folhaParametroApiProvider.update(folhaParametroModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaParametroDriftProvider.insert(folhaParametroModel);
      } else {
        return await folhaParametroApiProvider.insert(folhaParametroModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaParametroDriftProvider.delete(id) ?? false;
    } else {
      return await folhaParametroApiProvider.delete(id) ?? false;
    }
  }
}