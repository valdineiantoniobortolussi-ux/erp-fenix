import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_indice_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_indice_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilIndiceRepository {
  final ContabilIndiceApiProvider contabilIndiceApiProvider;
  final ContabilIndiceDriftProvider contabilIndiceDriftProvider;

  ContabilIndiceRepository({required this.contabilIndiceApiProvider, required this.contabilIndiceDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilIndiceDriftProvider.getList(filter: filter);
    } else {
      return await contabilIndiceApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilIndiceModel?>? save({required ContabilIndiceModel contabilIndiceModel}) async {
    if (contabilIndiceModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilIndiceDriftProvider.update(contabilIndiceModel);
      } else {
        return await contabilIndiceApiProvider.update(contabilIndiceModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilIndiceDriftProvider.insert(contabilIndiceModel);
      } else {
        return await contabilIndiceApiProvider.insert(contabilIndiceModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilIndiceDriftProvider.delete(id) ?? false;
    } else {
      return await contabilIndiceApiProvider.delete(id) ?? false;
    }
  }
}