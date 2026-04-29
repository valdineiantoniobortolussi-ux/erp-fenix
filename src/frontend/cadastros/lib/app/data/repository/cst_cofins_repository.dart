import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/cst_cofins_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cst_cofins_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CstCofinsRepository {
  final CstCofinsApiProvider cstCofinsApiProvider;
  final CstCofinsDriftProvider cstCofinsDriftProvider;

  CstCofinsRepository({required this.cstCofinsApiProvider, required this.cstCofinsDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cstCofinsDriftProvider.getList(filter: filter);
    } else {
      return await cstCofinsApiProvider.getList(filter: filter);
    }
  }

  Future<CstCofinsModel?>? save({required CstCofinsModel cstCofinsModel}) async {
    if (cstCofinsModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cstCofinsDriftProvider.update(cstCofinsModel);
      } else {
        return await cstCofinsApiProvider.update(cstCofinsModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cstCofinsDriftProvider.insert(cstCofinsModel);
      } else {
        return await cstCofinsApiProvider.insert(cstCofinsModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cstCofinsDriftProvider.delete(id) ?? false;
    } else {
      return await cstCofinsApiProvider.delete(id) ?? false;
    }
  }
}