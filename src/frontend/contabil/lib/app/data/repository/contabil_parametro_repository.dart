import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_parametro_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_parametro_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilParametroRepository {
  final ContabilParametroApiProvider contabilParametroApiProvider;
  final ContabilParametroDriftProvider contabilParametroDriftProvider;

  ContabilParametroRepository({required this.contabilParametroApiProvider, required this.contabilParametroDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilParametroDriftProvider.getList(filter: filter);
    } else {
      return await contabilParametroApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilParametroModel?>? save({required ContabilParametroModel contabilParametroModel}) async {
    if (contabilParametroModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilParametroDriftProvider.update(contabilParametroModel);
      } else {
        return await contabilParametroApiProvider.update(contabilParametroModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilParametroDriftProvider.insert(contabilParametroModel);
      } else {
        return await contabilParametroApiProvider.insert(contabilParametroModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilParametroDriftProvider.delete(id) ?? false;
    } else {
      return await contabilParametroApiProvider.delete(id) ?? false;
    }
  }
}