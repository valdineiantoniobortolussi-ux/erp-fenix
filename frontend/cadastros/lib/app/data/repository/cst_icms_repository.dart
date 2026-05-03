import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/cst_icms_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cst_icms_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CstIcmsRepository {
  final CstIcmsApiProvider cstIcmsApiProvider;
  final CstIcmsDriftProvider cstIcmsDriftProvider;

  CstIcmsRepository({required this.cstIcmsApiProvider, required this.cstIcmsDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cstIcmsDriftProvider.getList(filter: filter);
    } else {
      return await cstIcmsApiProvider.getList(filter: filter);
    }
  }

  Future<CstIcmsModel?>? save({required CstIcmsModel cstIcmsModel}) async {
    if (cstIcmsModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cstIcmsDriftProvider.update(cstIcmsModel);
      } else {
        return await cstIcmsApiProvider.update(cstIcmsModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cstIcmsDriftProvider.insert(cstIcmsModel);
      } else {
        return await cstIcmsApiProvider.insert(cstIcmsModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cstIcmsDriftProvider.delete(id) ?? false;
    } else {
      return await cstIcmsApiProvider.delete(id) ?? false;
    }
  }
}