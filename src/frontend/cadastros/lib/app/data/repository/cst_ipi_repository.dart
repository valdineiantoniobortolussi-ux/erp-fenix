import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/cst_ipi_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cst_ipi_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CstIpiRepository {
  final CstIpiApiProvider cstIpiApiProvider;
  final CstIpiDriftProvider cstIpiDriftProvider;

  CstIpiRepository({required this.cstIpiApiProvider, required this.cstIpiDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cstIpiDriftProvider.getList(filter: filter);
    } else {
      return await cstIpiApiProvider.getList(filter: filter);
    }
  }

  Future<CstIpiModel?>? save({required CstIpiModel cstIpiModel}) async {
    if (cstIpiModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cstIpiDriftProvider.update(cstIpiModel);
      } else {
        return await cstIpiApiProvider.update(cstIpiModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cstIpiDriftProvider.insert(cstIpiModel);
      } else {
        return await cstIpiApiProvider.insert(cstIpiModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cstIpiDriftProvider.delete(id) ?? false;
    } else {
      return await cstIpiApiProvider.delete(id) ?? false;
    }
  }
}